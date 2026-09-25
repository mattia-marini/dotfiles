local M = {}

local utils = require('lua.utils.misc')

function M.surround(l, r)
  local low_row, low_col, high_row, high_col = utils.getSelectionBound()
  local text = vim.api.nvim_buf_get_lines(0, low_row - 1, high_row, true)
  local line_count = #text
  text[line_count] = text[line_count]:sub(1, high_col - 1) .. r .. text[line_count]:sub(high_col)
  text[1] = text[1]:sub(1, low_col - 1) .. l .. text[1]:sub(low_col)
  vim.api.nvim_buf_set_lines(0, low_row - 1, high_row, true, text)

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
end

return M
