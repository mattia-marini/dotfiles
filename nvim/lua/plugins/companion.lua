return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = true,
  cmd = {
    "CodeCompanion",
    "CodeCompanionCmd",
    "CodeCompanionActions",
    "CodeCompanionChat",
  },
}
