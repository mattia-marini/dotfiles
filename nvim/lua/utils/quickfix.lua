local function remove_qf_item()
  -- print("REMOVING")
  -- print("lines")
  -- print(vim.inspect(qf_lines))

  local qf_lines = vim.fn.getqflist()

  local cursor_pos_row = vim.api.nvim_win_get_cursor(0)[1];

  table.remove(qf_lines, cursor_pos_row)

  vim.fn.setqflist(qf_lines, 'r')
  vim.cmd("copen")
end

return {
  remove_qf_item = remove_qf_item
}
