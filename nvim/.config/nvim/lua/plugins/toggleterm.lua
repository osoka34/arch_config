return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
		})

		vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", {
			noremap = true,
			silent = true,
			desc = "Toggle terminal",
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local function make_term(cmd, direction)
			return Terminal:new({
				cmd = cmd,
				hidden = true,
				direction = direction,
				float_opts = direction == "float" and { border = "rounded" } or nil,
				on_open = function(term)
					vim.cmd("startinsert!")
					local opts = { buffer = term.bufnr, silent = true }
					-- Esc goes to the agent; use these to get back to Neovim
					vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "<C-q>", function()
						term:toggle()
					end, opts)
				end,
			})
		end

		local lazygit = make_term("lazygit", "tab")
		local herdr = make_term("herdr", "tab")

		vim.keymap.set("n", "<leader>gg", function()
			lazygit:toggle()
		end, { desc = "Lazygit" })

		vim.keymap.set("n", "<leader>ah", function()
			if vim.fn.executable("herdr") == 0 then
				vim.notify(
					"herdr not found — install: curl -fsSL https://herdr.dev/install.sh | sh",
					vim.log.levels.WARN,
					{ title = "Herdr" }
				)
				return
			end
			herdr:toggle()
		end, { desc = "Herdr" })

	end,
}
