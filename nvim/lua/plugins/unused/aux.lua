local aux = {}

function aux.P(arg)
  print(vim.inspect(arg))
end

aux.hi_groups = {
  "ColorColumn",
  "Conceal",
  "CurSearch",
  "Cursor",
  "lCursor",
  "CursorIM",
  "CursorColumn",
  "CursorLine",
  "Directory",
  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",
  "EndOfBuffer",
  "TermCursor",
  "TermCursorNC",
  "ErrorMsg",
  "WinSeparator",
  "Folded",
  "FoldColumn",
  "SignColumn",
  "Substitute",
  "LineNr",
  "LineNrAbove",
  "LineNrBelow",
  "CursorLineNr",
  "CursorLineFold",
  "CursorLineSign",
  "MatchParen",
  "ModeMsg",
  "MsgArea",
  "MsgSeparator",
  "MoreMsg",
  "NonText",
  "Normal",
  "NormalFloat",
  "NormalNC",
  "Pmenu",
  "PmenuSel",
  "PmenuSbar",
  "PmenuThumb",
  "Question",
  "QuickFixLine",
  "Search",
  "SpecialKey",
  "SpellBad",
  "SpellCap",
  "SpellLocal",
  "SpellRare",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "Title",
  "Visual",
  "VisualNOS",
  "WarningMsg",
  "Whitespace",
  "WildMenu",
  "WinBar" }

aux.ts_hi_groups = {
  "@tag",
  "@type",
  "@debug",
  "@field",
  "@float",
  "@label",
  "@macro",
  "@define",
  "@method",
  "@number",
  "@repeat",
  "@string",
  "@boolean",
  "@comment",
  "@include",
  "@keyword",
  "@preproc",
  "@constant",
  "@function",
  "@operator",
  "@property",
  "@text.uri",
  "@variable",
  "@character",
  "@exception",
  "@namespace",
  "@parameter",
  "@structure",
  "@text.todo",
  "@text.title",
  "@conditional",
  "@constructor",
  "@punctuation",
  "@storageclass",
  "@text.literal",
  "@string.escape",
  "@constant.macro",
  "@function.macro",
  "@string.special",
  "@text.reference",
  "@text.underline",
  "@type.definition",
  "@constant.builtin",
  "@function.builtin",
}

function aux.print_hi_group()
  for _, hg in ipairs(aux.ts_hi_groups) do
    --print(hg)
    vim.api.nvim_echo({ { hg, hg } }, false, {})
  end
end

function aux.print_vim_hi_group()
  for _, hg in ipairs(aux.hi_groups) do
    --print(hg)
    vim.api.nvim_echo({ { hg, hg } }, false, {})
  end
end

function aux.BG()
  vim.api.nvim_set_hl(0, "Normal", { bg = none })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })
end

function aux.getSelectionBound()
  local _, row_1, col_1 = unpack(vim.fn.getpos("v"))
  local row_2, col_2 = unpack(vim.api.nvim_win_get_cursor(0))
  col_2 = col_2 + 1
  --print(row_1, col_1, row_2, col_2)

  -- Visual mode (v) done
  if vim.api.nvim_get_mode().mode == "v" then
    if row_2 < row_1 then
      return row_2, col_2, row_1, col_1 + 1
    elseif row_2 == row_1 then
      return row_1, math.min(col_1, col_2), row_1, math.max(col_1, col_2) + 1
    else
      return row_1, col_1, row_2, col_2 + 1
    end
  end

  -- Visual line mode (V) done
  if vim.api.nvim_get_mode().mode == "V" then
    if row_1 <= row_2 then
      col_1 = 1
      col_2 = #(vim.api.nvim_buf_get_lines(0, row_2 - 1, row_2, true)[1]) + 1 --occhio che è 0 based
    else
      col_2 = 1
      col_1 = #(vim.api.nvim_buf_get_lines(0, row_1 - 1, row_1, true)[1]) + 1
      local s = (vim.api.nvim_buf_get_lines(0, row_1 - 1, row_1, true)[1]) --occhio che è 0 based
    end
    local low_row, high_row = math.min(row_1, row_2), math.max(row_1, row_2)
    local low_col, high_col = math.min(col_1, col_2), math.max(col_1, col_2)
    return low_row, low_col, high_row, high_col
  end
  --print(low_row, low_col, high_row, high_col)

  --Visual block (^V) to do
end





