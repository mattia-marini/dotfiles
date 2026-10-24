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

	return source_dir
end

local function stop(buf)
	local job = jobs[buf]
	if not job then
		return
	end

	jobs[buf] = nil

	for _, id in ipairs({ job.watcher, job.zathura, job.initial }) do
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

				if code ~= 0 or vim.fn.filereadable(output) ~= 1 then
					fail("Initial Typst compilation failed")
					return
				end

				state.zathura = vim.fn.jobstart({
					"zathura", output,
				}, {
					on_exit = function()
						vim.schedule(function()
							if jobs[buf] == state then
								state.zathura = nil
							end
						end)
					end,
				})

				if not state.zathura or state.zathura <= 0 then
					fail("Failed to start Zathura")
					return
				end

				-- Continue recompiling changes in the background.
				state.watcher = vim.fn.jobstart({
					"typst", "watch",
					"--root", root,
					source, output,
				}, {
					cwd = root,
					on_exit = function(_, watch_code)
						vim.schedule(function()
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
					fail("Failed to start Typst watcher")
					return
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
