return {
	'saghen/blink.cmp',
	dependencies = { "giuxtaposition/blink-cmp-copilot" },
	version = '*',
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		sources = {
			default = { 'lsp', 'path', 'buffer', 'copilot' },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
				},
				lsp = {
					-- name = 'LSP',
					-- module = 'blink.cmp.sources.lsp',
					-- score_offset = 0,
					async = true,
					-- timeout_ms = 0,
				}
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		completion = {
			documentation = {
				window = {
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
				},
				auto_show = true,
				auto_show_delay_ms = 2,
				treesitter_highlighting = true,
			},
			menu = {
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection",
			}
		},
		keymap = {
			preset = 'default',
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
			-- ['<C-l>'] = { 'show_documentation', 'fallback' },
			['<C-Enter>'] = { 'accept' },
			['<C-l>'] = { 'accept' },
		},
		cmdline = {
			keymap = {
				preset = 'default',
				['<C-k>'] = { 'select_prev', 'fallback' },
				['<C-j>'] = { 'select_next', 'fallback' },
				['<C-Enter>'] = { 'accept' },
				['<C-l>'] = { 'accept' },
			},
			completion = {
				ghost_text = { enabled = false },
				menu = { auto_show = true }
			},
		}
	},
	opts_extend = { "sources.default" }
}
