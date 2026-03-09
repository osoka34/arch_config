return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local navic = require("nvim-navic")

		require("lualine").setup({
			options = {
				-- theme = "gruvbox",
				-- theme = "tokyonight",
				-- theme = "dracula",
				theme = "catppuccin",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{ "filename" },
				},
			},
		})
	end,
	dependencies = {
		-- "ellisonleao/gruvbox.nvim",
		-- "dracula/vim",
		-- "gruvbox/vim",
		"folke/tokyonight.nvim",
		"SmiteshP/nvim-navic",
		"catppuccin/nvim",
	},
}
