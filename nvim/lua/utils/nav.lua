local function is_special_pattern_char(c)
  local special_characters = {
    ["("] = true,
    [")"] = true,
    ['['] = true,
    [']'] = true
  }

  return special_characters[c] ~= nil
end

local function get_pattern_from_char_set(char_set)
  local pattern = ""
  for _, c in ipairs(char_set) do
    if (is_special_pattern_char(c)) then
      pattern = pattern .. "%" .. c
    else
      pattern = pattern .. c
    end
  end
  return pattern
end

local function find_last_occurence(s, char_set)
  local pattern = get_pattern_from_char_set(char_set)
  return s:find("[" .. pattern .. "]" .. "[^" .. pattern .. "]*$")
end

local function find_first_occurence(s, char_set)
  local pattern = get_pattern_from_char_set(char_set)
  return s:find("[" .. pattern .. "]")
end

local function go_to_next_paired_char(char_set)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  local curr_line = vim.api.nvim_get_current_line()
  local first_line_half = curr_line:sub(0, cursor_pos[2] + 1)
  local second_line_half = curr_line:sub(cursor_pos[2] + 2, -1)


  local matched_pos = find_first_occurence(second_line_half, char_set)

  print(matched_pos)
  if (matched_pos) then
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1], matched_pos + #first_line_half - 1 })
  end
end

local function go_to_prev_paired_char(char_set)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  local curr_line = vim.api.nvim_get_current_line()
  local first_line_half = curr_line:sub(0, cursor_pos[2])
  -- local second_line_half = curr_line:sub(cursor_pos[2] + 1, -1)


  local matched_pos = find_last_occurence(first_line_half, char_set)

  print(matched_pos)
  if (matched_pos) then
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1], matched_pos - 1 })
  end
end

return {
  go_to_prev_paired_char = go_to_prev_paired_char,
  go_to_next_paired_char = go_to_next_paired_char,
}
