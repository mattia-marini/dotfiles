local function default_coloscheme(name, name2)
	return {
		name,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme(name2)
			-- require("utils.colorscheme").colorscheme_no_bg(name2)
		end
	}
end

return {
	{ 'neanias/everforest-nvim', },
	{ 'arcticicestudio/nord-vim', },
	{ 'mhartington/oceanic-next', },
	{ 'glepnir/oceanic-material', },
	{ 'projekt0n/github-nvim-theme', },
	{ 'arzg/vim-colors-xcode', },
	{ 'sainnhe/gruvbox-material', },
	{ 'joshdick/onedark.vim', },
	{ 'embark-theme/vim',            as = 'embark', },
	{ 'rose-pine/neovim',            as = 'rose-pine', },
	{ 'catppuccin/vim',              as = 'catppuccin', },
	default_coloscheme("sainnhe/gruvbox-material", "gruvbox-material"),
}
