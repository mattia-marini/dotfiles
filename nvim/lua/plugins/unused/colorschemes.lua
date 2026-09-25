-- Default options:
--
--[[
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "",  -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
--]]
--

local function removeBackground()
  vim.api.nvim_set_hl(0, "Normal", { bg = none })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = none })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = none })
  vim.api.nvim_set_hl(0, "StatusLine", { italic = true })

  vim.api.nvim_set_hl(0, "TabLineFill", { bg = none })
  vim.api.nvim_set_hl(0, "TabLine", { bg = none })
  --vim.api.nvim_set_hl(0, "TabLineSel", { bold = true, italic = true })

  vim.api.nvim_set_hl(0, "Pmenu", { bg = none })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = none })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = none })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = none })

  vim.api.nvim_set_hl(0, "Normal", { bg = none })
  --vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
end

function Colorscheme(arg)
  vim.cmd.colorscheme(arg)
  removeBackground()
end

vim.api.nvim_create_user_command("Colorscheme", "lua Colorscheme(<q-args>)",
  { nargs = 1, complete = function() return vim.fn.getcompletion("colorscheme ", "cmdline") end })

if vim.g.neovide then
  vim.cmd("colorscheme everforest")
else
  vim.cmd("Colorscheme everforest")
end
