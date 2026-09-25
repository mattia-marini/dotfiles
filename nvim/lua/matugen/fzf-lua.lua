local M = {}
local common = require("matugen.common")
local colors = common.load_matugen_colors()
local blend = common.blend

local preview_bg = colors.background and blend(colors.background, colors.surface_variant, 0.4) or colors.surface_variant

M.colors = {
	-- Main window
	FzfLuaNormal = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	FzfLuaNormalFloat = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	FzfLuaBorder = {
		fg = colors.outline,
		bg = colors.surface,
	},

	FzfLuaBackdrop = {
		bg = colors.background,
	},

	FzfLuaTitle = {
		fg = colors.on_primary,
		bg = colors.primary,
		bold = true,
	},

	FzfLuaTitleFlags = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	-- Input
	FzfLuaPrompt = {
		fg = colors.primary,
		bg = colors.surface,
		bold = true,
	},

	FzfLuaPromptPrefix = {
		fg = colors.primary,
		bg = colors.surface,
		bold = true,
	},

	FzfLuaPromptText = {
		fg = colors.on_surface,
		bg = colors.surface,
	},

	-- Results
	FzfLuaCursor = {
		fg = colors.on_primary,
		bg = colors.primary,
	},

	FzfLuaCursorLine = {
		fg = colors.on_primary_container,
		bg = colors.primary_container,
	},

	FzfLuaHeader = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	FzfLuaHeaderBind = {
		fg = colors.secondary,
		bg = colors.surface,
	},

	FzfLuaHeaderText = {
		fg = colors.on_surface_variant,
		bg = colors.surface,
	},

	-- Matching text
	FzfLuaFzfMatch = {
		fg = colors.primary,
		bold = true,
	},

	FzfLuaFzfPointer = {
		fg = colors.primary,
	},

	FzfLuaFzfSpinner = {
		fg = colors.secondary,
	},

	FzfLuaFzfInfo = {
		fg = colors.on_surface_variant,
	},

	-- Preview
	FzfLuaPreviewNormal = {
		fg = colors.on_surface,
		bg = preview_bg,
	},

	FzfLuaPreviewBorder = {
		fg = colors.outline_variant,
		bg = preview_bg,
	},

	FzfLuaPreviewTitle = {
		fg = colors.on_secondary,
		bg = colors.secondary,
		bold = true,
	},

	-- Scrollbars
	FzfLuaScrollbar = {
		fg = colors.outline,
		bg = colors.surface_variant,
	},

	-- Directory/file-specific elements
	FzfLuaDirIcon = {
		fg = colors.secondary,
	},

	FzfLuaDirPart = {
		fg = colors.on_surface_variant,
	},

	FzfLuaPath = {
		fg = colors.on_surface_variant,
	},

	FzfLuaFilePart = {
		fg = colors.on_surface,
	},

	FzfLuaBufName = {
		fg = colors.primary,
		bold = true,
	},

	FzfLuaBufNr = {
		fg = colors.outline,
	},

	FzfLuaBufFlagAlt = {
		fg = colors.tertiary,
	},

	FzfLuaBufFlagCur = {
		fg = colors.primary,
		bold = true,
	},
}

function M.set_colors()
	for group, opts in pairs(M.colors) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

return M
