-- Diff / review stack for agentic coding (inspired by craftzdog).
-- <leader>do = Diffview; <leader>av (avante) = same review after agent edits.
-- In Diffview: Tab / ]f = next file, S-Tab / [f = prev, X = restore file.

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
						vim.schedule(function()
							pcall(vim.cmd, "DiffviewFocusFiles")
						end)
					else
						vim.cmd("DiffviewClose")
					end
				end,
				desc = "Toggle Diffview",
			},
		},
		opts = function()
			local actions = require("diffview.actions")
			return {
				enhanced_diff_hl = true,
				view = {
					default = {
						layout = "diff2_horizontal",
						winbar_info = true,
					},
					merge_tool = {
						layout = "diff3_horizontal",
					},
				},
				file_panel = {
					listing_style = "list",
					win_config = {
						position = "left",
						width = 40,
					},
				},
				keymaps = {
					view = {
						{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
						{ "n", "[f", actions.select_prev_entry, { desc = "Prev file" } },
					},
					file_panel = {
						{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
						{ "n", "[f", actions.select_prev_entry, { desc = "Prev file" } },
					},
				},
			}
		end,
	},
}
