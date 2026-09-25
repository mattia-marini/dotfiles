local M = {}
local colors = require("matugen.common").load_matugen_colors()

M.colors = {
	-- Completion menu
	BlinkCmpMenu = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	BlinkCmpMenuBorder = {
		fg = colors.outline,
		bg = colors.surface,
	},

	BlinkCmpMenuSelection = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	BlinkCmpMenuMatch = {
		fg = colors.primary,
		bold = true,
	},

	BlinkCmpLabel = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	BlinkCmpLabelMatch = {
		fg = colors.primary,
		bg = colors.surface,
		bold = true,
	},

	BlinkCmpLabelDetail = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	BlinkCmpLabelDescription = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	-- Kind icons / labels
	BlinkCmpKind = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	BlinkCmpSource = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	-- Scrollbar (keeps the empty strip the same color as the menu)
	BlinkCmpScrollBarGutter = {
		bg = colors.surface,
	},

	BlinkCmpScrollBarThumb = {
		bg = colors.outline,
	},

	BlinkCmpKindText = {
		fg = colors.primary,
		bg = colors.surface,
	},

	BlinkCmpKindMethod = {
		fg = colors.primary,
		bg = colors.surface,
	},

	BlinkCmpKindFunction = {
		fg = colors.primary,
		bg = colors.surface,
	},

	BlinkCmpKindConstructor = {
		fg = colors.tertiary,
		bg = colors.surface,
	},

	BlinkCmpKindField = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	BlinkCmpKindVariable = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	BlinkCmpKindClass = {
		fg = colors.tertiary,
		bg = colors.surface,
	},

	BlinkCmpKindInterface = {
		fg = colors.tertiary,
		bg = colors.surface,
	},

	BlinkCmpKindModule = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	BlinkCmpKindProperty = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	BlinkCmpKindKeyword = {
		fg = colors.primary,
		bg = colors.surface,
	},

	BlinkCmpKindSnippet = {
		fg = colors.tertiary,
		bg = colors.surface,
	},

	-- Documentation
	BlinkCmpDoc = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	BlinkCmpDocBorder = {
		fg = colors.outline,
		bg = colors.surface,
	},

	BlinkCmpDocCursorLine = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	BlinkCmpDocSeparator = {
		fg = colors.outline,
	},

	BlinkCmpDocSignatureHelp = {
		fg = colors.on_surface,
		bg = colors.surface_variant,
	},

	BlinkCmpDocSignatureHelpBorder = {
		fg = colors.outline,
		bg = colors.surface_variant,
	},

	-- Signature help
	BlinkCmpSignatureHelp = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	BlinkCmpSignatureHelpBorder = {
		fg = colors.outline,
		bg = colors.surface,
	},

	BlinkCmpSignatureHelpActiveParameter = {
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
