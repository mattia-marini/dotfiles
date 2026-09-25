vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
	group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
	callback = function()
		pcall(vim.system, { "kitten", "@", "set-user-vars", "in_editor=1" })
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
	callback = function()
		pcall(vim.system, { "kitten", "@", "set-user-vars", "in_editor" })
	end,
})
