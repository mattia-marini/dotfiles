local cmp = require 'cmp'

cmp.setup({
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol",
  --     max_width = 50,
  --     symbol_map = { Copilot = "" }
  --   })
  -- },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      require('luasnip').lsp_expand(args.body) --For luasnips disabilitato perchè fotte con tab
    end,
  },
  matching = { disallow_fullfuzzy_matching = false },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
    },
    -- completion = {
    --   border = 'rounded', --'single', 'double', 'rounded', 'none'.
    --   -- winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
    --   -- col_offset = 0,
    --   -- side_padding = 1
    -- }
    --   cmp.config.window.bordered(
    --
    --   { winhighlight = 'Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None' }
    -- )
    -- documentation = {
    --   border = 'single', --'single', 'double', 'rounded', 'none'.
    --   winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
    --   col_offset = 0,
    --   side_padding = 1
    -- }
    -- cmp.config.window.bordered(
    --   { winhighlight = 'Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None' }
    -- ),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-i>'] = cmp.mapping.scroll_docs(-4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = "copilot" },
    --{ name = 'luasnips' }, commentato in quanto
    { name = 'buffer' },
  }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline({
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    --['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = 'buffer' },
    { name = 'path' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    --['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = 'path' },
    { name = 'cmdline' }
  }
})
