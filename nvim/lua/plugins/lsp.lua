local function config()
	local on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true)
		-- Enable completion triggered by <c-x><c-o>
		--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set({ 'i', 'n' }, '<C-u>', vim.lsp.buf.signature_help, bufopts)
		--vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)


		--vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)
		--[[
  vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  --]]
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<space>N', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('v', '<space>a', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

		-- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = false } end, bufopts)
		--
		vim.api.nvim_create_user_command("ToggleHints", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, {})
	end

	-- local ufo_capabilities = vim.lsp.protocol.make_client_capabilities()
	-- ufo_capabilities.textDocument.foldingRange = {
	--   --for ufo lsp folding
	--   dynamicRegistration = false,
	--   lineFoldingOnly = true
	-- }
	-- local cmp_capabilities = capabilities
	local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()
	local capabilities = {}

	for key, value in pairs(cmp_capabilities) do capabilities[key] = value end
	-- for key, value in pairs(ufo_capabilities) do capabilities[key] = value end




	vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { noremap = true })
	vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { noremap = true })
	vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { noremap = true })
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap = true })


	vim.diagnostic.config({ signs = false })


	vim.lsp.config("clangd", {
	  on_attach = on_attach,
	  update_in_insert = false,
	  capabilities = capabilities
	  --cmd = {'clangd', '--fallback-style=/Users/mattia/Desktop/clang-format'},
	  --capabilities = capabilities
	})
	vim.lsp.enable("clangd")

	-- vim.lsp.config("ccls", {
	-- 	on_attach = on_attach,
	-- 	update_in_insert = false,
	-- 	capabilities = capabilities,
	-- 	single_file_support = true
	-- 	--cmd = {'clangd', '--fallback-style=/Users/mattia/Desktop/clang-format'},
	-- 	--capabilities = capabilities
	-- })
	-- vim.lsp.enable("ccls")


	vim.lsp.config("texlab", {
		-- , '-vvvv'
		cmd = { 'texlab' },
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("texlab")

	vim.lsp.config("lua_ls", {
		cmd = { 'lua-language-server' },
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim', 'use', -- Nvim
						"sn", "s", "t", "i", "f", "fmt" -- LuaSnips
					},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library =
					    (function()
						    local libs = {}

						    -- Nvim apis
						    for _, lib in ipairs(vim.api.nvim_get_runtime_file("", true)) do
							    table.insert(libs, lib)
						    end

						    --  LuaRocks
						    -- local luarocks_paths = vim.system({ "luarocks", "config", "rocks_trees" }, { text = true }):wait()
						    -- if luarocks_paths.code == 0 then
						    --   for path in luarocks_paths.stdout:gmatch("root%s*=%s*\"([^,]*)\"") do
						    --     table.insert(libs, path)
						    --     print(path)
						    --   end
						    -- else
						    --   print("Couln't get luarocks paths")
						    -- end

						    --  LuaRocks
						    table.insert(libs, vim.fs.normalize("~/.luarocks"))
						    local luarock_project_root = vim.fs.root(0, function(name, path)
							    return name:match('%.rockspec$') ~= nil
						    end)
						    if luarock_project_root then
							    table.insert(libs, luarock_project_root)
						    end

						    -- print(vim.inspect(libs))
						    -- for _, lib in luarocks_paths do
						    --   table.insert(libs, lib)
						    -- end

						    return libs
					    end)(),
					checkThirdParty = false
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
	vim.lsp.enable("lua_ls")

	vim.lsp.config("millet", {
		cmd = { 'millet-ls' },
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
		single_file_support = true
		--root_dir = function()return vim.fn.getcwd()end
	})
	vim.lsp.enable("millet")

	vim.lsp.config("sourcekit", {
		--single_file_support = true,
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
		filetypes = { "swift", "metal" },
		root_dir = require('lspconfig').util.root_pattern("buildServer.json", "*.xcodeproj", "*.xcworkspace",
			".git",
			"compile_commands.json", "Package.swift")
	})
	vim.lsp.enable("sourcekit")

	vim.lsp.config("ts_ls", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
		commands = {
			OrganizeImports = {
				function()
					local params = {
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
						title = ""
					}
					vim.lsp.buf.execute_command(params)
				end,
				description = "Organize imports"
			},
		}
	})
	vim.lsp.enable("ts_ls")

	vim.lsp.config("cssls", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
	})
	vim.lsp.enable("cssls")

	vim.lsp.config("html", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
		filetypes = { "html", "templ", "jsp" }
	})
	vim.lsp.enable("html")

	vim.lsp.config("emmet_language_server", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("emmet_language_server")

	vim.lsp.config("rust_analyzer", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("rust_analyzer")

	-- vim.lsp.config("jdtls", {
	-- 	on_attach = on_attach,
	-- 	update_in_insert = false,
	-- 	capabilities = capabilities,
	-- 	root_markers = { 'pom.xml', '.mvn', 'mvnw', 'mvnw.cmd', 'build.gradle', 'build.gradle.kts', '.git' },
	-- })
	-- vim.lsp.enable("jdtls")

	vim.lsp.config("lemminx", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities,
	})
	vim.lsp.enable("lemminx")

	-- vim.lsp.config("pyright", {
	--   on_attach = on_attach,
	--   update_in_insert = false,
	--   capabilities = capabilities
	-- })
	-- vim.lsp.enable("pyright")

	vim.lsp.config("basedpyright", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("basedpyright")

	vim.lsp.config("wgsl_analyzer", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("wgsl_analyzer")

	vim.lsp.config("ty", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("ty")

	vim.lsp.config("jls", {
		command = "jsl",
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("jls")

	vim.lsp.config("tinymist", {
		on_attach = on_attach,
		update_in_insert = false,
		capabilities = capabilities
	})
	vim.lsp.enable("tinymist")

	-- require('lspconfig').jls.setup({
	-- 	cmd = { '<path-to-jls>/dist/lang_server_mac.sh' }, -- or linux/windows
	-- })


	-- require 'lspconfig'.superhtml.setup {
	--   on_attach = on_attach,
	--   update_in_insert = false,
	--   capabilities = capabilities
	-- }
	-- require 'lspconfig'.htmx.setup {
	--   on_attach = on_attach,
	--   update_in_insert = false,
	--   capabilities = capabilities
	-- }
end

return { 'neovim/nvim-lspconfig', config = config }
