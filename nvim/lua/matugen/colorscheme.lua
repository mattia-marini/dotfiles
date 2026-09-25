local M = {}
local common = require("matugen.common")
local colors = common.load_matugen_colors()
local blend = common.blend

-- Subtle derived surfaces so "emphasis" groups don't look like heavy blocks.
local surface_dim = colors.surface and blend(colors.surface, colors.surface_variant, 0.18) or colors.surface_variant
local surface_soft = colors.surface and blend(colors.surface, colors.surface_variant, 0.42) or colors.surface_variant

M.colors = {
	-- Core editor
	Normal = {
		fg = colors.on_background,
		bg = colors.surface,
	},

	NormalFloat = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	FloatBorder = {
		fg = colors.outline,
		bg = colors.surface,
	},

	CursorLine = {
		bg = surface_soft,
	},

	CursorColumn = {
		bg = surface_dim,
	},

	ColorColumn = {
		bg = surface_dim,
	},

	SignColumn = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	FoldColumn = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	Folded = {
		fg = colors.on_surface_variant,
		bg = surface_dim,
		italic = true,
	},

	LineNr = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	CursorLineNr = {
		fg = colors.primary,
		bg = colors.surface,
		bold = true,
	},

	-- Status / tab lines
	StatusLine = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	StatusLineNC = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	NormalNC = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	TabLine = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	TabLineFill = {
		bg = colors.surface,
	},

	TabLineSel = {
		fg = colors.on_primary,
		bg = colors.primary,
		bold = true,
	},

	-- Popup menus
	Pmenu = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	PmenuSel = {
		fg = colors.on_primary,
		bg = colors.primary,
	},

	PmenuSbar = {
		bg = colors.surface_variant,
	},

	PmenuThumb = {
		bg = colors.outline,
	},

	-- Search / selection
	Visual = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	Search = {
		fg = colors.on_primary,
		bg = colors.primary,
	},

	IncSearch = {
		fg = colors.on_primary,
		bg = colors.primary,
		bold = true,
	},

	CurSearch = {
		fg = colors.on_primary,
		bg = colors.primary,
		bold = true,
	},

	Substitute = {
		fg = colors.on_secondary,
		bg = colors.secondary,
	},

	-- Diagnostics
	DiagnosticError = {
		fg = colors.error,
	},

	DiagnosticWarn = {
		fg = colors.tertiary,
	},

	DiagnosticInfo = {
		fg = colors.primary,
	},

	DiagnosticHint = {
		fg = colors.secondary,
	},

	DiagnosticOk = {
		fg = colors.primary,
	},

	-- Diagnostic virtual text
	DiagnosticVirtualTextError = {
		fg = colors.error,
		bg = colors.error_container,
	},

	DiagnosticVirtualTextWarn = {
		fg = colors.on_tertiary_container,
		bg = colors.tertiary_container,
	},

	DiagnosticVirtualTextInfo = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	DiagnosticVirtualTextHint = {
		fg = colors.on_secondary_container,
		bg = colors.secondary_container,
	},

	-- Diagnostics in the sign column
	DiagnosticSignError = {
		fg = colors.error,
	},

	DiagnosticSignWarn = {
		fg = colors.tertiary,
	},

	DiagnosticSignInfo = {
		fg = colors.primary,
	},

	DiagnosticSignHint = {
		fg = colors.secondary,
	},

	-- Messages
	ErrorMsg = {
		fg = colors.on_error_container,
		bg = colors.error_container,
		bold = true,
	},

	WarningMsg = {
		fg = colors.on_tertiary_container,
		bg = colors.tertiary_container,
	},

	ModeMsg = {
		fg = colors.primary,
		bold = true,
	},

	MoreMsg = {
		fg = colors.primary,
	},

	Question = {
		fg = colors.primary,
	},

	-- Diff
	DiffAdd = {
		fg = colors.on_secondary_container,
		bg = colors.secondary_container,
	},

	DiffChange = {
		fg = colors.on_tertiary_container,
		bg = colors.tertiary_container,
	},

	DiffDelete = {
		fg = colors.on_error_container,
		bg = colors.error_container,
	},

	DiffText = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
		bold = true,
	},

	-- Git / version-control style groups
	Added = {
		fg = colors.secondary,
	},

	Changed = {
		fg = colors.tertiary,
	},

	Removed = {
		fg = colors.error,
	},

	-- Separators / borders
	WinSeparator = {
		fg = colors.outline_variant,
	},

	VertSplit = {
		fg = colors.outline_variant,
	},

	NonText = {
		fg = colors.outline_variant,
	},

	Whitespace = {
		fg = colors.outline_variant,
	},

	-- Syntax
	Comment = {
		fg = colors.outline,
		italic = true,
	},

	String = {
		fg = colors.secondary,
	},

	Character = {
		fg = colors.secondary,
	},

	Number = {
		fg = colors.tertiary,
	},

	Boolean = {
		fg = colors.tertiary,
	},

	Constant = {
		fg = colors.tertiary,
	},

	Identifier = {
		fg = colors.on_background,
	},

	Function = {
		fg = colors.primary,
	},

	Statement = {
		fg = colors.primary,
	},

	Keyword = {
		fg = colors.primary,
	},

	Type = {
		fg = colors.tertiary,
	},

	Operator = {
		fg = colors.on_surface_variant,
	},

	PreProc = {
		fg = colors.secondary,
	},

	Special = {
		fg = colors.secondary,
	},

	Todo = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
		bold = true,
	},
}

function M.set_colors()
	for group, opts in pairs(M.colors) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

return M
