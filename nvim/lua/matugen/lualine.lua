local M = {}
local colors = require("matugen.common").load_matugen_colors()

M.theme = {
	normal = {
		a = {
			fg = colors.on_primary,
			bg = colors.primary,
			gui = "bold",
		},
		b = {
			fg = colors.on_surface,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},

	insert = {
		a = {
			fg = colors.on_secondary,
			bg = colors.secondary,
			gui = "bold",
		},
		b = {
			fg = colors.on_surface,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},

	visual = {
		a = {
			fg = colors.on_tertiary,
			bg = colors.tertiary,
			gui = "bold",
		},
		b = {
			fg = colors.on_surface,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},

	replace = {
		a = {
			fg = colors.on_error,
			bg = colors.error,
			gui = "bold",
		},
		b = {
			fg = colors.on_surface,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},

	command = {
		a = {
			fg = colors.on_primary_container,
			bg = colors.primary_container,
			gui = "bold",
		},
		b = {
			fg = colors.on_surface,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},

	inactive = {
		a = {
			fg = colors.on_surface_variant,
			bg = colors.surface_variant,
		},
		b = {
			fg = colors.on_surface_variant,
			bg = colors.surface,
		},
		c = {
			fg = colors.on_surface_variant,
			bg = colors.background,
		},
	},
}

return M
