vim.api.nvim_create_user_command("EditInit", [[tabnew ~/.config/nvim/init.lua]], {})
vim.api.nvim_create_user_command("Plugins", [[tabnew ~/.config/nvim/plugin/packer-plugin.lua]], {})
vim.api.nvim_create_user_command("Conf", [[tabnew ~/.config/nvim/plugin]], {})
vim.api.nvim_create_user_command("Py",
  [[cd /Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/python_workspace/]], {})
vim.api.nvim_create_user_command("Cpp",
  [[cd /Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/cpp_workspace/]], {})
vim.api.nvim_create_user_command("Js", [[cd /Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/js/]],
  {})

vim.api.nvim_create_user_command("Latex",
  [[cd /Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/latex_workspace/]], {})

vim.api.nvim_create_user_command("Parsers", [[echo nvim_get_runtime_file('parser', v:true)]], {})

vim.api.nvim_create_user_command("Colorscheme",
  function(args)
    require("utils.colorscheme").colorscheme_no_bg(args.args)
  end,
  {
    nargs = 1,
    complete = function() return vim.fn.getcompletion("colorscheme ", "cmdline") end
  })

if vim.g.neovide then
  vim.cmd("colorscheme everforest")
end
