--[[
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    html = { "prettier" },
    ["*"] = { "injected" },
  },
  log_level = vim.log.levels.DEBUG,
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_format = "fallback",
  -- },
})

require("conform").formatters.injected = {
  -- Set the options field
  options = {
    ignore_errors = false,
  }
}

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
--]]
local opts = {
	formatters_by_ft = {
		python = function()
			vim.api.nvim_create_user_command("OrganizeImports",
				function()
					require("conform").format({ formatters = { "ruff_organize_imports" } })
				end, {})
			vim.api.nvim_create_user_command("Lint",
				function()
					require("conform").format({ formatters = { "ruff_fix" } })
				end, {})
			return { "ruff_format", "ruff_organize_imports" }
		end,
		javascript = { "biome" },
		typescript = { "biome" },
		javascriptreact = { "biome" },
		typescriptreact = { "biome" },
		json = { "biome" },
		jsonc = { "biome" },
		css = { "biome" },
	},
	notify_no_formatters = true,
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- Set up format-on-save
	-- format_on_save = { timeout_ms = 500 },
	-- Customize formatters
	-- formatters = {
	--   shfmt = {
	--     prepend_args = { "-i", "2" },
	--   },
	-- },
}

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<space>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = opts,
	-- init = function()
	--   -- If you want the formatexpr, here is the place to set it
	--   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
