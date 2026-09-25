--[[
local builtin = require("telescope.builtin")
vim.keymap.set("n", "ff", builtin.find_files, {})
vim.keymap.set("n", "fb", builtin.buffers, {})
--vim.api.nvim_set_keymap( "n", "<space>fb", ":Telescope file_browser<CR><Esc>l", { noremap = true })
require("telescope").setup {}
--[[
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
--]]
--require("telescope").load_extension("file_browser")
--]]
--
-- local actions = require("telescope.actions")
--
-- require("telescope").setup({
--   defaults = {
--     mappings = {
--       i = {
--         -- Insert mode mappings
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--       },
--       n = {
--         -- Normal mode mappings (optional)
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--       },
--     },
--   },
-- })

return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts =
	    function()
		    local actions = require("telescope.actions")
		    return {
			    defaults = {
				    mappings = {
					    i = {
						    -- Insert mode mappings
						    ["<C-j>"] = actions.move_selection_next,
						    ["<C-k>"] = actions.move_selection_previous,
					    },
					    n = {
						    -- Normal mode mappings (optional)
						    ["<C-j>"] = actions.move_selection_next,
						    ["<C-k>"] = actions.move_selection_previous,
					    },
				    },
			    },
		    }
	    end
}
