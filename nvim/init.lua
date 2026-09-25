require("config.options")
require("config.keymaps")
require("config.commands")

require("enhancements")

require("config.lazy")

-- Apply the Matugen palette after lazy.nvim loads the default colorscheme, so
-- these colors actually take effect instead of being overwritten. It also
-- re-applies on every `ColorScheme` change via an autocommand.
require("matugen").setup()
