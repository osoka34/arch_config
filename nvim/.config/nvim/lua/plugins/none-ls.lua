-- Formatting moved to conform.nvim.
-- none-ls keeps non-formatter sources (lint + code actions).
return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.code_actions.gomodifytags,
				},
			})

			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
				desc = "Diagnostic float",
			})
		end,
	},
}
