return {
	-- 	{
	-- 		"rmagatti/auto-session",
	-- 		config = function()
	-- 			require("auto-session").setup({
	-- 				log_level = "error",
	-- 				auto_session_enable_last_session = false,
	-- 				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
	-- 				auto_session_enabled = true,
	-- 				auto_save_enabled = true, -- <<-- Вот эта опция для автосейва
	-- 				auto_restore_enabled = true,
	-- 				auto_session_suppress_dirs = { -- Папки, где автосейв не нужен
	-- 					"~/",
	-- 					"~/Downloads",
	-- 					"/",
	-- 				},
	-- 			})
	-- 		end,
	-- 	},
}
