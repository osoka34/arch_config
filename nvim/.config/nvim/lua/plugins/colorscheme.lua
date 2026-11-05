return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000, -- Загружается раньше других плагинов
		config = function()
			local transparent = false
			require("tokyonight").setup({
				style = "night", -- Доступные стили: "storm", "night", "moon"
				transparent = transparent, -- Если нужен прозрачный фон, установите true
				styles = {
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				terminal_colors = true, -- Включить поддержку цветов в терминале
				on_highlights = function(hl, c)
					hl.Comment = { fg = "#7ec07c", italic = true } -- Можно c.green, можно "#9ece6a", можно свой
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				style = "dark", -- Доступные стили: "dark", "light"
				transparent_background = false, -- Если нужен прозрачный фон, установите true
				transparency = false, -- Если нужен прозрачный фон, установите true
				term_colors = true, -- Включить поддержку цветов в терминале
				custom_highlights = function(colors)
					return {
						Comment = { fg = "#7ec07c", italic = true }, -- ярко-зеленый, можешь изменить
					}
				end,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			local transparency = false
			-- Default options:
			require("gruvbox").setup({

				-- terminal_colors = true, -- add neovim terminal colors
				-- undercurl = true,
				-- underline = true,
				-- bold = true,
				-- italic = {
				-- 	strings = true,
				-- 	emphasis = true,
				-- 	comments = true,
				-- 	operators = false,
				-- 	folds = true,
				-- },
				-- strikethrough = true,
				-- invert_selection = false,
				-- invert_signs = false,
				-- invert_tabline = false,
				-- invert_intend_guides = false,
				-- inverse = true, -- invert background for search, diffs, statuslines and errors
				-- contrast = "soft", -- can be "hard", "soft" or empty string
				palette_overrides = {
					-- bright_red = "#d79921", -- dark orange
					bright_red = "#fabd2f", -- light yellow
					bright_green = "#8ec07c", -- light green
					yellow = "#ffcc00",
				},
				overrides = {
					Function = { fg = "#b8bb26" },
					Identifier = { fg = "#fabd2f" },
					-- CursorLine = { bg = "NONE" },
					-- CursorColumn = { bg = "NONE" },
				},
				-- dim_inactive = false,
				transparent_mode = transparency,
			})

			vim.cmd("highlight CursorLine guibg=NONE ctermbg=NONE")
			vim.cmd("highlight CursorColumn guibg=NONE ctermbg=NONE")
		end,
	},
}
