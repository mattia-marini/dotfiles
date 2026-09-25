-- Maps
vim.api.nvim_set_keymap('n', '<space>w', ':wa<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
--vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})
-- vim.api.nvim_set_keymap('i', 'œ', '<', { noremap = true })
-- vim.api.nvim_set_keymap('i', 'ø', '>', { noremap = true })
-- vim.api.nvim_set_keymap('v', 'œ', '<', {})
-- vim.api.nvim_set_keymap('v', 'ø', '>', {})

vim.api.nvim_set_keymap('n', '<space>n', '<C-w><C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>p', '<C-w><C-p>', { noremap = true })

-- local silk = function() return require('silk.interaction.window') end
vim.keymap.set({ 'n', 'v' }, '<space>k', '<C-w>k', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<space>j', '<C-w>j', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<space>l', '<C-w>l', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<space>h', '<C-w>h', { silent = true })

vim.api.nvim_set_keymap('n', '<space><tab>', 'gt', { silent = true })
vim.api.nvim_set_keymap('n', '<space>p', 'gT', { silent = true })
vim.api.nvim_set_keymap('n', '<space>e', ':Oil<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>E', ':vsplit | Oil<CR>', { silent = true })

-- vim.api.nvim_set_keymap('n', '<C-h>', '5zh', {})
-- vim.api.nvim_set_keymap('n', '<C-l>', '5zl', {})

-- vim.api.nvim_set_keymap('n', '<space>a', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<space>H', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<space>n', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<space>m', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true })

vim.keymap.set({ 'n' }, 'ml', 'J', { noremap = true })


-- Folding
vim.api.nvim_set_keymap('n', 'fa', 'zM', {})
vim.api.nvim_set_keymap('n', 'fA', 'zR', {})
vim.api.nvim_set_keymap('n', '-', 'za', {})
vim.api.nvim_set_keymap('n', '_', 'zA', {})


-- Misc/util
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-N>', {})


-- Surround
local surround = function() return require('utils.surround') end
vim.api.nvim_set_keymap('v', '(', "", { callback = function() surround().surround('(', ')') end })
vim.api.nvim_set_keymap('v', ')', "", { callback = function() surround().surround('(', ')') end })
vim.api.nvim_set_keymap('v', '[', "", { callback = function() surround().surround('[', ']') end })
vim.api.nvim_set_keymap('v', ']', "", { callback = function() surround().surround('[', ']') end })
vim.api.nvim_set_keymap('v', '{', "", { callback = function() surround().surround('{', '}') end })
vim.api.nvim_set_keymap('v', '}', "", { callback = function() surround().surround('{', '}') end })
vim.api.nvim_set_keymap('v', '<', "", { callback = function() surround().surround('<', '>') end })
vim.api.nvim_set_keymap('v', '>', "", { callback = function() surround().surround('<', '>') end })
vim.api.nvim_set_keymap('v', '"', "", { callback = function() surround().surround('"', '"') end })
vim.api.nvim_set_keymap('v', '\'', "", { callback = function() surround().surround('\'', '\'') end })
vim.api.nvim_set_keymap('v', '`', "", { callback = function() surround().surround('`', '`') end })



-- Movement
vim.api.nvim_set_keymap('i', '<C-h>', "<Left>", {})
vim.api.nvim_set_keymap('i', '<C-l>', "<Right>", {})
vim.api.nvim_set_keymap('i', '<C-k>', "<Up>", {})
vim.api.nvim_set_keymap('i', '<C-j>', "<Down>", {})

vim.api.nvim_set_keymap('n', 'K', '5k', {})
vim.api.nvim_set_keymap('v', 'K', '5k', {})
vim.api.nvim_set_keymap('n', 'J', '5j', {})
vim.api.nvim_set_keymap('v', 'J', '5j', {})


-- vim.keymap.set('n', '<C-k>', function() require("utils.cursor").move_half_page("up") end, { noremap = true })
-- vim.keymap.set('n', '<C-j>', function() require("utils.cursor").move_half_page("down") end, { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<C-u>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<C-d>', { noremap = true })

vim.keymap.set({ 'n', 'v' }, 'L', '5l', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'H', '5h', { noremap = true })

-- Comments
vim.keymap.set('v', 'c', 'gc', { remap = true })

-- Travel by brakets
local nav = require("utils.nav")
vim.keymap.set("n", "<C-8>", function()
	nav.go_to_prev_paired_char({ '{', '[', '(' })
	-- require("mini.ai").move_cursor("left", 'a', 'b', { search_method = 'prev' })
end
)

vim.keymap.set("n", "<C-9>", function()
	nav.go_to_next_paired_char({ '}', ']', ')' })
	-- require("mini.ai").move_cursor("right", 'a', 'b', { search_method = 'next' })
end
)

vim.keymap.set({ "n", "v" }, "<space>Cc",
	function()
		require("CopilotChat").open()
	end, {
		desc = "CopilotChat - Open chat",
	}
)

vim.keymap.set("n", "<Space>tf", function()
	-- require("telescope.builtin").find_files()
	require("fzf-lua").files()
end
)

vim.keymap.set("n", "<Space>tg", function()
	-- require("telescope.builtin").live_grep()
	require("fzf-lua").live_grep_native()
end
)

vim.keymap.set("n", "<Space>T", ":vnew | term<CR>", { silent = true })

vim.keymap.set("n", "<space>D", "<cmd>NoiceDismiss<CR>")
