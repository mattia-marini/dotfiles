-- require 'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all" (the four listed parsers should always be installed)
--   --ensure_installed = { "c", "lua", "vim", "help" },
--
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   --sync_install = false,
--
--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   --auto_install = true,
--
--   -- List of parsers to ignore installing (for "all")
--   --ignore_install = { "tex" },
--
--   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--   -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--
--   indent = {
--     enable = true,
--   },
--
--   incremental_selection = {
--     enable = true,
--   },
-- }

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  init = function()
    -- highlight, indent, ensure_installed
    local filetypes = {
      lua = { highlight = true, indent = true, ensure = false },
      python = { highlight = true, indent = true, ensure = false },
      rust = { highlight = true, indent = true, ensure = false },
      tex = { highlight = true, indent = true, ensure = false }, -- Latex
      toml = { highlight = true, indent = true, ensure = false },
      javascript = { highlight = true, indent = true, ensure = false },
      c = { highlight = true, indent = true, ensure = false },
      cpp = { highlight = true, indent = true, ensure = false },
      markdown = { highlight = true, indent = true, ensure = true },
      markdown_inline = { highlight = true, indent = true, ensure = true },
      vim = { highlight = true, indent = true, ensure = true },
      vimdoc = { highlight = true, indent = true, ensure = true }
    }

    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local ensureInstalled = {}
    for ft, opts in pairs(filetypes) do
      if opts.ensure then
        table.insert(ensureInstalled, vim.treesitter.language.get_lang(ft))
      end
    end

    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)



    for ft, opts in pairs(filetypes) do
      if opts.highlight or opts.indent then
        vim.api.nvim_create_autocmd('FileType', {
          pattern = ft,
          callback = function()
            local installed = require('nvim-treesitter.config').get_installed()
            if installed and vim.tbl_contains(installed, vim.treesitter.language.get_lang(ft)) then
              -- Enable treesitter highlightghlighting and disable regex syntax

              if opts.highlight then
                pcall(vim.treesitter.start)
              end
              -- Enable treesitter-based indentation
              if opts.indent then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end
            end
          end,
        })
      end
    end
  end
}
