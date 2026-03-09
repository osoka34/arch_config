return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl", -- Новый модуль для версии 3
		config = function()
			-- vim.cmd([[
			--     highlight IndentBlanklineChar guifg=#3c3836 gui=nocombine
			--     highlight IndentBlanklineContextChar guifg=#d79921 gui=nocombine
			--     highlight IndentBlanklineContextStart guisp=#d79921 gui=underline
			-- ]])

			require("ibl").setup({
				indent = {
					char = "▏", -- Тонкий индикатор (лучше видно в Gruvbox)
					-- highlight = "IndentBlanklineChar",
				},
				-- scope = {
				-- 	enabled = true,
				-- 	show_start = true,
				-- 	show_end = false,
				-- 	highlight = "IndentBlanklineContextChar",
				-- 	injected_languages = true,
				-- 	priority = 1024, -- Высокий приоритет
				-- },
				-- exclude = {
				-- 	filetypes = {
				-- 		"help",
				-- 		"alpha",
				-- 		"dashboard",
				-- 		"neo-tree",
				-- 		"Trouble",
				-- 		"lazy",
				-- 		"mason",
				-- 		"notify",
				-- 	},
				-- 	buftypes = { "terminal", "nofile" },
				-- },
			})
		end,
	},
}
