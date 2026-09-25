local left = 0;
local right = -1;
local function bisect_l(go_left)
  if right == -1 then
    right = #vim.api.nvim_get_current_line()
  end

  local cur = vim.api.nvim_win_get_cursor(0)

  if go_left then
    vim.api.nvim_win_set_cursor(0, { cur[1], math.floor((cur[2] + left) / 2) })
    right = cur[2]
  else
    vim.api.nvim_win_set_cursor(0, { cur[1], math.floor((cur[2] + right) / 2) })
    left = cur[2]
  end
end

vim.api.nvim_buf_set_keymap(0, "n", "<C-b>", "", { callback = function() bisect_l(true) end })
vim.api.nvim_buf_set_keymap(0, "n", "<C-n>", "", { callback = function() print("sesso"); bisect_l(false) end })
