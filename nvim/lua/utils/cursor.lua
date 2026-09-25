local M = {}

-- function M.move_half_page_up()
--   local top = vim.fn.line("w0")
--   local mid = top + math.floor(vim.fn.winheight(0) / 2)
--   vim.api.nvim_win_set_cursor(0, { mid, 0 })
--
--
--   vim.cmd.
--       vim.api.nvim_command("normal! <C-k>")
-- end

-- ---@param direction "up" | "down"
-- function M.move_half_page(direction)
-- local top = vim.fn.line("w0")
-- local mid = top + math.floor(vim.fn.winheight(0) / 2)
-- local bottom = vim.fn.line("w$")
--
--
-- vim.api.nvim_win_set_cursor(0, { mid, 0 })
--
-- if
-- print(top, mid, bottom)
-- local cmd
-- if direction == "up" then
--   cmd = "normal! <C-u>"
-- elseif direction == "down" then
--   cmd = "normal! <C-d>"
-- end


-- print(vim.cmd(cmd))
-- local top = vim.fn.line("w0")
-- local window_height = vim.fn.winheight(0)
-- print(window_height)
--
-- vim.cmd("normal! <C-d>")
-- local mid = top + math.floor(window_height / 2)
-- vim.api.nvim_win_set_cursor(0, { mid, 0 })
--
-- vim.api.nvim_command("normal! <C-k>")
-- end

return M
