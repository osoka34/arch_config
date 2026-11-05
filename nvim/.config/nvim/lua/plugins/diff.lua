-- Diff / review stack for agentic coding (inspired by craftzdog).
-- Note: codediff uses <leader>v* because <leader>d* is taken by DAP.

return {
	{
		"craftzdog/mini.diff",
		branch = "feat/grouping",
		config = function()
			require("mini.diff").setup({
				view = {
					-- whole hunk overlay, like `git diff`
					overlay_style = "hunk",
				},
				mappings = {
					goto_next = "]c",
					goto_prev = "[c",
				},
			})

			vim.keymap.set("n", "<leader>gd", function()
				require("mini.diff").toggle_overlay()
			end, { desc = "Toggle MiniDiff overlay" })
		end,
	},
	{
		"esmuellert/codediff.nvim",
		cmd = { "CodeDiff" },
		keys = {
			{ "<leader>vv", "<cmd>CodeDiff<cr>", desc = "Toggle CodeDiff" },
			{ "<leader>vh", "<cmd>CodeDiff history %<cr>", desc = "File history" },
			{ "<leader>vH", "<cmd>CodeDiff history<cr>", desc = "Repo history" },
		},
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = { "GitLink" },
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", desc = "Yank GitHub URL", mode = { "n", "v" } },
		},
		opts = {},
	},
}
