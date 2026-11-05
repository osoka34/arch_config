-- plugins/telescope.lua:
return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					-- Установка прозрачности окна
					-- winblend = 80, -- Измените значение от 0 до 100 для регулировки прозрачности

					-- Настройка границ окна
					border = true,
					-- borderchars = {
					-- 	prompt = { "─", "│", " ", "│", "╭", "╮", " ", " " },
					-- 	results = { " ", "│", "─", "│", " ", " ", "╯", "╰" },
					-- 	preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					-- },
				},
				pickers = {
					-- Вы можете настроить конкретные пикеры, если необходимо
				},
				extensions = {
					-- Подключение расширений
				},
			})

			-- Настройка групп выделения для прозрачности
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })

			-- telescope setup
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>o", builtin.buffers, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		-- This is your opts table
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
