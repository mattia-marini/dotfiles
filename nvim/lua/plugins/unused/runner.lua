-- local opts = {
--   lang = {
--     c = {
--       buildAndRun = function(args)
--         return "make"
--       end
--     },
--     javascript = {
--       userArgs = function()
--         local root = vim.fs.root(0, { 'package.json', 'node_modules', '.git' })
--         local srcDir
--
--         if root then
--           for name, type in vim.fs.dir(root) do
--             if name == "src" and type == "directory" then srcDir = name end
--           end
--         end
--
--         if srcDir then srcDir = vim.fs.joinpath(root, "/src") end
--         return { root = srcDir or root }
--       end,
--       buildAndRun = function(args)
--         if args.user.root then
--           return "DT && npm start"
--         else
--           return "cd " .. args.default.currFileDir .. " && node " .. args.default.currFileName .. args.default.args
--         end
--       end
--     },
--     rust = {
--       buildAndRun = function(args)
--         return "cargo run -- " .. args.default.args
--       end
--     },
--     java = {
--       userArgs = function()
--         local root = vim.fs.root(0, { 'package.json', 'node_modules', '.git' })
--         local srcDir
--
--         if root then
--           for name, type in vim.fs.dir(root) do
--             if name == "src" and type == "directory" then srcDir = name end
--           end
--         end
--
--         if srcDir then srcDir = vim.fs.joinpath(root, "/src") end
--         return { root = srcDir or root }
--       end,
--       buildAndRun = function(args)
--         local mvn_root_files = {
--           'build.xml', -- Ant
--           'pom.xml',   -- Maven
--         }
--         local gradle_root_files = {
--           'settings.gradle',     -- Gradle (multi-project)
--           'settings.gradle.kts', -- Gradle (multi-project)
--           'build.gradle',        -- Gradle
--           'build.gradle.kts',    -- Gradle
--         }
--
--         local mvn_root = vim.fs.root(0, mvn_root_files)
--         local gradle_root = vim.fs.root(0, mvn_root_files)
--
--         if mvn_root then
--           return "cd '" .. mvn_root .. "' && DT && mvn exec:java ".. args.default.args
--         elseif gradle_root then
--           return "cd '" .. gradle_root .. "' && DT && gradle run"
--         else
--           return "cd '" ..
--               args.default.currFileDir ..
--               "' && javac -d ./bin " ..
--               args.default.currFileName .. " && cd bin && java " .. args.default.currFileName:gsub("%.java", "")
--         end
--       end
--     },
--   }
-- }
--
local opts = {
	print_command = true,
	run_mode = {
		mode = "kitty",
		opts = {
			type = "tab",
			-- copy_env = false
			-- match = "recent:0"
		}
	}
}

return { 'mattia-marini/runner.nvim', opts = opts }
