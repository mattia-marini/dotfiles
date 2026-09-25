return {
	'stevearc/oil.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts =
	{
		columns = {
			"icon",
			-- "permissions",
			-- { "size", align = "right" }, -- Add this line
			-- "mtime",
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["~"] = "actions.tcd",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
			["gp"] = "actions.preview",
			["gc"] = "actions.cd",
			[","] = "actions.change_sort",

			["<Space>w"] = ":w<CR>",
			-- ["<Esc>"] = ":q<CR>",

			-- Inside your oil.setup() keymaps table:
			["<leader>sy"] = "actions.copy_to_system_clipboard",
			["<leader>sp"] = "actions.paste_from_system_clipboard",
			["<leader>p"] = "actions.yank_entry",

			["<Space>T"] = {
				desc = 'Open terminal',
				callback = function()
					local oil = require("oil")
					local dir = oil.get_current_dir()
					if dir then
						vim.fn.jobstart({ "kitty", "--directory", dir }, { detach = true })
					else
						vim.notify("Could not get current directory from Oil",
							vim.log.levels.WARN)
					end
				end,
			},
			["gs"] = {
				desc = "Toggle file size column",
				callback = function()
					local oil = require("oil")
					local config = require("oil.config")
					local cols = vim.deepcopy(config.columns)

					local has_size = false
					for i, col in ipairs(cols) do
						if col == "size" then
							has_size = true
							table.remove(cols, i)
							break
						end
					end

					if not has_size then
						table.insert(cols, "size")
					end

					oil.set_columns(cols)
				end,
			},
			-- ['yp'] = {
			--   desc = 'Copy filepath to system clipboard',
			--   callback = function()
			--     require('oil.actions').copy_entry_path.callback()
			--     vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
			--   end,
			-- },
		},
		delete_to_trash = true,
	}
}
