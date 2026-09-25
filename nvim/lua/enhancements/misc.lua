-- Quickfix enhancements
local remove_qf_item = require("utils.quickfix").remove_qf_item

vim.api.nvim_create_user_command("RemoveQFItem", remove_qf_item, {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", remove_qf_item, { buffer = true })
	end
})


-- Setting in_editor variable for Kitty terminal
require("utils.kitty")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
		vim.api.nvim_set_hl(0, "FloatTitle", { link = "Title" })
	end,
})
