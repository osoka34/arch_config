-- Diff / review stack for agentic coding (inspired by craftzdog).
-- <leader>do = Diffview; codediff stays on <leader>v* (DAP owns most <leader>d*).

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
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		keys = {
			{
				"<leader>do",
				function()
					local lib = require("diffview.lib")
					if next(lib.views) == nil then
						vim.cmd("DiffviewOpen")
					else
						vim.cmd("DiffviewClose")
					end
				end,
				desc = "Toggle Diffview",
			},
		},
		opts = {
			enhanced_diff_hl = true,
		},
	},
}
