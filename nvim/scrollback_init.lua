-- require("config.options")
-- require("config.keymaps")

vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/kitty-scrollback.nvim')                        -- lazy.nvim
vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site/pack/packer/opt/kitty-scrollback.nvim')        -- packer
vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site/pack/mikesmithgh/start/kitty-scrollback.nvim') -- pack
require('kitty-scrollback').setup({
  -- put your kitty-scrollback.nvim configurations here
})
-- require("config.commands")
-- require("config.enhancements")
--
-- require("config.lazy")
