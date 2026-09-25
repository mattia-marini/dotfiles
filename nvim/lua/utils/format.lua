local M = {}
local function split_long_lines(lines, max_len)
  local result = {}

  for _, line in ipairs(lines) do
    while #line > max_len do
      table.insert(result, line:sub(1, max_len))
      line = line:sub(max_len + 1)
    end
    table.insert(result, line)
  end

  return result
end

function M.hard_wrap_lines(start_line, end_line, max_len)
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, split_long_lines(lines, max_len))
end

return M
