local function remove_bg()
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

local function colorscheme_no_bg(arg)
  vim.cmd.colorscheme(arg)
  remove_bg()
end

return {
  colorscheme_no_bg = colorscheme_no_bg,
  remove_bg = remove_bg
}
