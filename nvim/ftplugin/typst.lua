-- Store jobs globally so state persists across ftplugin re-loads
_G._typst_jobs = _G._typst_jobs or {}
local jobs = _G._typst_jobs

local scan_lines = 30

local function get_output_path(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		return vim.fn.tempname() .. ".pdf"
	end
	-- Create a unique output path per file path using sha256
	local hash = vim.fn.sha256(name):sub(1, 12)
	vim.fn.mkdir("/tmp/typst", "p")
	return string.format("/tmp/typst/%s.pdf", hash)
end

local function infer_root(buf)
	local source = vim.api.nvim_buf_get_name(buf)
	local source_dir = vim.fs.dirname(source)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, scan_lines, false)

	for _, line in ipairs(lines) do
		local path = line:match('^%s*#import%s+"([^"]+)"')

		if path then
			local imported = vim.fs.normalize(
				vim.fs.joinpath(source_dir, path)
			)

			if vim.fn.filereadable(imported) == 1 then
				local root = vim.fs.dirname(imported)

				while root and root ~= "/" do
					local rel = vim.fs.relpath(root, source)

					if rel and rel ~= ".."
					    and not vim.startswith(rel, "../") then
						return root
					end

					root = vim.fs.dirname(root)
				end

				return "/"
			end
		end
	end

	return vim.fs.root(source, { ".git" }) or source_dir
end

local function close_watch_tab(state)
	state.stopping = true

	if state.watcher and state.watcher > 0 then
		local id = state.watcher
		state.watcher = nil
		vim.fn.jobstop(id)
		-- Give the process a moment to exit so closing the tab doesn't prompt.
		pcall(vim.fn.jobwait, { id }, 1000)
	end

	local tab = state.watch_tab
	local buf = state.watch_buf
	state.watch_tab = nil
	state.watch_buf = nil

	if not tab or not vim.api.nvim_tabpage_is_valid(tab) then
		if buf and vim.api.nvim_buf_is_valid(buf) then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
		return
	end

	local win = vim.api.nvim_tabpage_get_win(tab)
	if win and vim.api.nvim_win_is_valid(win) then
		local ok = pcall(vim.api.nvim_win_close, win, true)
		if ok then
			return
		end
	end

	-- Fallback: switch to the tab and close it explicitly.
	local current = vim.api.nvim_get_current_tabpage()
	if current ~= tab then
		pcall(vim.api.nvim_set_current_tabpage, tab)
	end
	pcall(vim.cmd, "tabclose!")
	if current ~= tab and vim.api.nvim_tabpage_is_valid(current) then
		pcall(vim.api.nvim_set_current_tabpage, current)
	end
end

local function stop(buf)
	local job = jobs[buf]
	if not job then
		return
	end

	jobs[buf] = nil

	close_watch_tab(job)

	for _, id in ipairs({ job.zathura, job.initial }) do
		if id and id > 0 then
			vim.fn.jobstop(id)
		end
	end

	vim.notify("Typst watcher stopped")
end

local function compile_toggle()
	local buf = vim.api.nvim_get_current_buf()

	if jobs[buf] then
		stop(buf)
		return
	end

	if vim.bo[buf].modified then
		vim.cmd.write()
	end

	local source = vim.api.nvim_buf_get_name(buf)

	if source == "" then
		vim.notify("Save the Typst file first", vim.log.levels.ERROR)
		return
	end

	local root = infer_root(buf)
	local output = get_output_path(buf)

	local state = {}
	jobs[buf] = state

	local function fail(message)
		if jobs[buf] ~= state then
			return
		end

		jobs[buf] = nil

		if state.initial and state.initial > 0 then
			vim.fn.jobstop(state.initial)
		end
		close_watch_tab(state)
		if state.zathura and state.zathura > 0 then
			vim.fn.jobstop(state.zathura)
		end

		vim.notify(message, vim.log.levels.ERROR)
	end

	-- Produce the first valid PDF before launching Zathura.
	state.initial = vim.fn.jobstart({
		"typst", "compile",
		"--root", root,
		source, output,
	}, {
		cwd = root,
		on_exit = function(_, code)
			vim.schedule(function()
				if jobs[buf] ~= state then
					return
				end

				state.initial = nil

				local compiled = code == 0
					and vim.fn.filereadable(output) == 1

				if not compiled then
					-- Keep the watcher running so its output can be used
					-- for debugging, even though the first compile failed.
					vim.notify(
						"Initial Typst compilation failed",
						vim.log.levels.ERROR
					)
				end

				if compiled then
					state.zathura = vim.fn.jobstart({
						"zathura", output,
					}, {
						on_exit = function()
							vim.schedule(function()
								if jobs[buf] ~= state then
									return
								end

								state.zathura = nil
								jobs[buf] = nil
								close_watch_tab(state)
								vim.notify(
									"Zathura closed; Typst watcher stopped"
								)
							end)
						end,
					})

					if not state.zathura or state.zathura <= 0 then
						fail("Failed to start Zathura")
						return
					end
				end

				-- Continue recompiling changes in a dedicated terminal tab.
				local previous_tab = vim.api.nvim_get_current_tabpage()
				vim.cmd("tabnew")
				state.watch_tab = vim.api.nvim_get_current_tabpage()

				state.watcher = vim.fn.jobstart({
					"typst", "watch",
					"--root", root,
					source, output,
				}, {
					cwd = root,
					term = true,
					on_exit = function(_, watch_code)
						vim.schedule(function()
							if state.stopping then
								state.watcher = nil
								return
							end

							if jobs[buf] ~= state then
								return
							end

							jobs[buf] = nil
							state.watcher = nil

							if watch_code ~= 0 then
								vim.notify(
									"Typst watcher exited with code " .. watch_code,
									vim.log.levels.ERROR
								)
							end
						end)
					end,
				})

				if not state.watcher or state.watcher <= 0 then
					state.watch_tab = nil
					pcall(vim.cmd, "tabclose")
					if vim.api.nvim_tabpage_is_valid(previous_tab) then
						pcall(vim.api.nvim_set_current_tabpage, previous_tab)
					end
					fail("Failed to start Typst watcher")
					return
				end

				state.watch_buf = vim.api.nvim_get_current_buf()
				vim.bo[state.watch_buf].bufhidden = "wipe"
				vim.bo[state.watch_buf].buflisted = false

				-- Keep the focus on the tab containing the document.
				if vim.api.nvim_tabpage_is_valid(previous_tab) then
					pcall(vim.api.nvim_set_current_tabpage, previous_tab)
				end

				vim.notify("Typst watcher started: " .. output)
			end)
		end,
	})

	if not state.initial or state.initial <= 0 then
		jobs[buf] = nil
		vim.notify("Failed to start Typst compilation", vim.log.levels.ERROR)
	end
end

-- Automatically clean up jobs if the buffer is closed/unloaded
vim.api.nvim_create_autocmd("BufUnload", {
	buffer = 0,
	callback = function()
		stop(vim.api.nvim_get_current_buf())
	end,
})

vim.api.nvim_buf_create_user_command(0, "CompileToggle", compile_toggle, {
	desc = "Toggle Typst compilation and PDF preview",
})

vim.keymap.set("n", "<leader>r", compile_toggle, {
	buffer = true,
	desc = "Toggle Typst compilation",
})
