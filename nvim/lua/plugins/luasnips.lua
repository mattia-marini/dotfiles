local function config()
  local ls = require("luasnip")
  ls.config.set_config({
    history = false,
    enable_autosnippets = true,
    delete_check_events = { "InsertLeave", "TextChangedI", "InsertEnter" },
    region_check_events = { "CursorMovedI", "InsertEnter", "InsertLeave", "CursorHoldI", "CursorHold", "CursorMoved" },
    update_events = { "TextChanged", "TextChangedI" },
    store_selection_keys = "<Tab>"
  })
  require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/luasnippets/" } })

  --per selezionare il testo e tenere il placeholder $VISUAL
  --serve per eliminare la jumplist una volta premuto esc
  vim.keymap.set(
    { "i", "s" }, "<Tab>",
    function()
      if ls.expandable() then
        ls.expand()
      elseif ls.jumpable(1) then
        ls.jump(1)
      else
        vim.api.nvim_feedkeys(string.format('%s', '\t'), 'n', true)
      end
    end
  )
end

return {
  'L3MON4D3/LuaSnip',
  config = config,
}

--[[
--Drops snippet when esc is pressed
vim.keymap.set(
  { "i", "v" }, "<Esc>",
  function()
    while (ls.jumpable(1) or ls.jumpable(-1)) do
      ls.unlink_current()
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
  end
)
function leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
    then
        ls.unlink_current()
    end
end
vim.keymap.set(
  {"i", "s"}, "<tab>",
  function()
    if ls.expand_or_jumpable() then
      ls.expand()
    else vim.api.nvim_feedkeys(string.format('%s', '\t'), 'n', true)
    end
  end
)

-- stop snippets when you leave to normal mode
--vim.api.nvim_command([[
--    autocmd ModeChanged * lua leave_snippet()
--)
vim.keymap.set(
  {"i", "s"}, "º",
  function()
    if ls.expand_or_jumpable() then
      ls.expand()
    end
  end
)
vim.keymap.set(
  {"i", "s"}, "¬",
  function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end
)
vim.keymap.set(
  {"i", "s"}, "∆",
  function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end
)
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]]
