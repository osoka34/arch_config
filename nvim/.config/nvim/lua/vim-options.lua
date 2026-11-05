-- Indent (keep 4 — fits Go)
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Look
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Files
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.fn.mkdir(vim.opt.undodir:get()[1], "p")

-- Timing / clipboard
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.clipboard:append("unnamedplus")

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Treat kebab-case as one word (CSS / flags)
vim.opt.iskeyword:append("-")

vim.cmd("colorscheme catppuccin")

-- Flash yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

-- Cursorline only in the active window
local cursorline_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursorline_group,
	command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = cursorline_group,
	command = "setlocal nocursorline",
})
