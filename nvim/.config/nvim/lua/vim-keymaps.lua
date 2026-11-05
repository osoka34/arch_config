vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, desc = "Horizontal split" })
vim.keymap.set("n", "<leader>w", "<C-w>w", { noremap = true, desc = "Next window" })

-- Reload config without leaving the session (Neovim 0.12+)
vim.keymap.set("n", "ZR", "<cmd>restart<CR>", { desc = "Restart Neovim" })

-- Edit without clobbering the yank register.
-- <leader>d stays diagnostic float; blackhole delete is <leader>D
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })
vim.keymap.set({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete (no yank)" })
vim.keymap.set({ "n", "v" }, "<leader>C", '"_c', { desc = "Change (no yank)" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste last yank" })

-- Helpers to copy context into Cursor (or any agent) chat
local agent = require("utils.agent")

vim.keymap.set("n", "<leader>yf", agent.yank_relative_path_with_line, {
	desc = "Yank relative path#L",
})
vim.keymap.set("n", "<leader>yp", agent.yank_absolute_path_with_line, {
	desc = "Yank absolute path#L",
})
vim.keymap.set("v", "<leader>cc", ":<C-u>lua require('utils.agent').copy_as_codeblock()<CR>", {
	desc = "Copy selection as markdown codeblock",
	silent = true,
})
