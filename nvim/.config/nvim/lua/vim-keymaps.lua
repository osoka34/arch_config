vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, desc = "Horizontal split" })
vim.keymap.set("n", "<leader>w", "<C-w>w", { noremap = true, desc = "Next window" })

-- Agentic coding helpers: paste paths / snippets into an external agent prompt
local agent = require("utils.agent")

vim.keymap.set("n", "<leader>yf", agent.yank_relative_path_with_line, {
	desc = "Yank relative path#L",
})
vim.keymap.set("n", "<leader>yp", agent.yank_absolute_path_with_line, {
	desc = "Yank absolute path#L",
})

-- Visual only: normal <leader>cc stays CopilotChat
vim.keymap.set("v", "<leader>cc", ":<C-u>lua require('utils.agent').copy_as_codeblock()<CR>", {
	desc = "Copy selection as markdown codeblock",
	silent = true,
})
