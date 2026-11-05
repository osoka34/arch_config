return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
		})

		vim.keymap.set({ "n" }, "<leader>t", "<cmd>ToggleTerm<cr>", {
			noremap = true,
			silent = true,
			desc = "Toggle terminal",
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "rounded",
			},
			on_open = function()
				vim.cmd("startinsert!")
			end,
		})

		-- Same chord as craftzdog's guide; <leader>gg as a non-`;` alternative
		local open_lazygit = function()
			lazygit:toggle()
		end
		vim.keymap.set("n", ";g", open_lazygit, { desc = "Lazygit" })
		vim.keymap.set("n", "<leader>gg", open_lazygit, { desc = "Lazygit" })
	end,
}
