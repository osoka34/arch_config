return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			current_line_blame = false,
			attach_to_untracked = false,
		})

		local gs = require("gitsigns")

		vim.keymap.set("n", "<leader>gb", function()
			gs.blame_line()
		end, { desc = "Blame current line" })

		vim.keymap.set("n", "<leader>gB", function()
			gs.blame()
		end, { desc = "Blame buffer" })

		vim.keymap.set("n", "<leader>gs", function()
			if #(gs.get_hunks() or {}) > 0 then
				gs.stage_buffer()
			else
				gs.reset_buffer_index()
			end
		end, { desc = "Toggle stage buffer" })

		vim.keymap.set("n", "<leader>gh", function()
			gs.stage_hunk()
		end, { desc = "Toggle stage hunk" })

		vim.keymap.set("n", "<leader>gp", function()
			gs.preview_hunk()
		end, { desc = "Preview hunk" })

		vim.keymap.set("n", "<leader>gr", function()
			gs.reset_hunk()
		end, { desc = "Reset hunk" })
	end,
}
