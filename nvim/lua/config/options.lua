vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
-- vim.o.mousescroll = 'ver:1,hor:1'
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.conceallevel = 1
vim.opt.wrap = false
vim.opt.cursorline = true

-- vim.g.terminal_emulator = 'wezterm'
vim.o.shell = '/usr/local/bin/fish'
vim.opt.ignorecase = true

-- vim.o.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.o.foldenable = true

-- vim.keymap.set('n', 'zR', function() require('lua.plugins.unused.ufo').openAllFolds() end)
-- vim.keymap.set('n', 'zM', function() require('lua.plugins.unused.ufo').closeAllFolds() end)
-- vim.keymap.set("n", "<C-I>", "<C-I>")
-- vim.keymap.set("n", "<Tab>", "<Nop>")
-- vim.keymap.set({ 'n', 'i' }, '<Tab>', "<Tab>")


vim.opt.laststatus = 0
vim.opt.cmdheight = 1
--
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- --vim.opt.cintent = false
--
-- vim.opt.smarttab = false
-- vim.opt.autoindent = false
-- vim.opt.smartindent = false

vim.opt.completeopt = "menu,preview,noinsert,popup"


vim.filetype.add({
	extension = {
		cl = "c",
	}
})

vim.o.winborder = "rounded"




if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_far_lines = 9999
	vim.o.guifont = "FuraMono Nerd Font:h18" -- text below applies for VimScript
	-- vim.cmd("colorscheme everforest")
	vim.g.neovide_confirm_quit = true
end
