return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			direction = "float", -- Открытие терминала в плавающем окне
			close_on_exit = true, -- Автоматическое закрытие терминала при выходе
			shell = vim.o.shell, -- Используем системный шелл
		})

		-- function _G.set_terminal_keymaps()
		--     -- local opts = {buffer = 0}
		--     -- Закрываем терминал при нажатии Esc
		--     vim.keymap.set({ "t" }, "<esc>", [[<C-\><C-n><cmd>ToggleTerm<cr>]], {})
		-- end

		-- Используем точную автокоманду для буферов терминала, созданных плагином toggleterm
		-- vim.cmd("autocmd! TermOpen *toggleterm#* lua set_terminal_keymaps()")

		-- Привязка клавиши <leader>t для открытия плавающего терминала
		vim.keymap.set({ "n" }, "<leader>t", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
	end,
}
