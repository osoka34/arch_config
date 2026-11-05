-- Editable file explorer (directory = buffer). Keep nvim-tree for tree UI;
-- use oil for rename/move/delete as text edits.
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		require("oil").setup({
			-- nvim-tree already owns the sidebar; don't steal :edit .
			default_file_explorer = false,
			columns = {
				"icon",
				{ "permissions", highlight = "Type" },
				{ "size", highlight = "String" },
				{ "mtime", highlight = "Keyword" },
			},
			keymaps = {
				["h"] = { "actions.parent", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
			},
			view_options = {
				show_hidden = true,
			},
			float = {
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				max_width = 200,
			},
			preview_win = {
				update_on_cursor_moved = true,
			},
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = true,
			},
		})

		-- Same chord as craftzdog: open oil float with live preview
		vim.keymap.set("n", "sf", function()
			require("oil").open_float(nil, { preview = {} })
		end, { desc = "Oil file explorer (float)" })
	end,
}
