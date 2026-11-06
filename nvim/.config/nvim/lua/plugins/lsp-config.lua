return {
	-- mason.nvim
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-navic").setup({
				highlight = true, -- Подсветка текущего контекста
				click = true, -- Включаем кликабельность
				lsp = {
					auto_attach = true, -- Автоматическое подключение к LSP
				},
			})
		end,
	},
	-- mason-lspconfig.nvim
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"gopls", -- Go
					-- "intelephense", -- PHP
					"phpactor",
				},
				automatic_installation = true, -- Автоматическая установка серверов
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"golangci-lint",
					"goimports",
					"goimports-reviser",
					"gomodifytags",
					-- "gotests",
					"stylua",
					"gofumpt",
					-- "golines",
					-- "ruff",
					-- "phpactor",
					-- "intelephense",
				},
				automatic_installation = true,
			})
		end,
	},
	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { -- Добавляем Telescope как зависимость
			"nvim-telescope/telescope.nvim",
			"SmiteshP/nvim-navic",
		},
		config = function()
			local navic = require("nvim-navic")

			vim.diagnostic.config({
				virtual_text = {
					source = "if_many",
					prefix = "●",
					spacing = 4,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
			end

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
				noremap = true,
				silent = true,
			})
			vim.keymap.set("n", "gr", function()
				require("telescope.builtin").lsp_references({
					reuse_win = true,
				})
			end, { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float()
			end, { noremap = true, silent = true })

			-- lua_ls: teach it about the Neovim `vim` global + runtime APIs
			vim.lsp.config("lua_ls", {
				filetypes = { "lua" },
				on_attach = on_attach,
				on_init = function(client)
					local path = client.workspace_folders
						and client.workspace_folders[1]
						and client.workspace_folders[1].name
					-- Respect a project .luarc.json when present (non-nvim Lua projects)
					if path and path ~= vim.fn.stdpath("config") then
						local luarc = path .. "/.luarc.json"
						local luarcc = path .. "/.luarc.jsonc"
						if vim.uv.fs_stat(luarc) or vim.uv.fs_stat(luarcc) then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
						runtime = {
							version = "LuaJIT",
							path = { "lua/?.lua", "lua/?/init.lua" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
						diagnostics = {
							globals = { "vim" },
						},
					})
				end,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- Настройка gopls (для Go)
			vim.lsp.config("gopls", {
				-- show_success_message = true, -- Отключаем сообщение об успешном запуске
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				-- root_dir = vim.lsp.root_pattern("go.mod", "go.work", ".git"),
				-- root_dir = vim.lsp.config.util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
					},
				},
				on_attach = on_attach,
			})

			vim.lsp.config("phpactor", {
				cmd = { "phpactor", "language-server" },
				filetypes = { "php" },
				on_attach = on_attach,
				settings = {
					phpactor = {
						environment = {
							phpVersion = "7.4.33", -- ⬅️ УКАЖИТЕ СВОЮ ВЕРСИЮ PHP ТУТ
						},
					},
				},
				on_init = function(client)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
	},
}
