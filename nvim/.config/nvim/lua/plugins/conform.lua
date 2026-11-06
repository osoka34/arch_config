return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo", "ToggleFormatter" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = false, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			default_format_opts = {
				timeout_ms = 2000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofumpt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {
					timeout_ms = 2000,
					lsp_format = "fallback",
				}
			end,
		})

		vim.api.nvim_create_user_command("ToggleFormatter", function()
			local bufnr = vim.api.nvim_get_current_buf()
			if vim.b[bufnr].disable_autoformat then
				vim.b[bufnr].disable_autoformat = false
				vim.notify("Formatter enabled for this buffer", vim.log.levels.INFO)
			else
				vim.b[bufnr].disable_autoformat = true
				vim.notify("Formatter disabled for this buffer", vim.log.levels.WARN)
			end
		end, { desc = "Toggle format-on-save for current buffer" })
	end,
}
