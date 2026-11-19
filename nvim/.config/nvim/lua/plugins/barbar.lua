return {
    "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons", -- Для иконок файлов
    config = function()
        require("barbar").setup({
            animation = true, -- Включает анимацию при перемещении буферов
            clickable = true, -- Разрешает взаимодействие мышкой
        })

        -- Привязки клавиш для переключения между буферами
        vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<CR>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>bd", "<cmd>BufferClose<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "Q", "<cmd>BufferClose<CR>", { noremap = true, silent = true })
    end,
}
