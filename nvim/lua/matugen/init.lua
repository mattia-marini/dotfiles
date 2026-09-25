local M = {}
M.colorscheme = require("matugen.colorscheme")
M.blink = require("matugen.blink")
M.fzf_lua = require("matugen.fzf-lua")
M.lualine = require("matugen.lualine")

local autocmd_registered = false

function M.set_hi_groups()
	M.colorscheme.set_colors()
	M.blink.set_colors()
	M.fzf_lua.set_colors()
end

--- Apply the Matugen palette and re-apply it on every `ColorScheme` event,
--- so changing the colorscheme doesn't wipe the Matugen colors.
function M.setup()
	M.set_hi_groups()

	if not autocmd_registered then
		autocmd_registered = true
		local group = vim.api.nvim_create_augroup("Matugen", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = group,
			pattern = "*",
			callback = function()
				M.set_hi_groups()
			end,
		})
	end
end

return M
