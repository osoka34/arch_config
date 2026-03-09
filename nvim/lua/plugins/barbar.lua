return {
    "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons", -- Для иконок файлов
    config = function()
        require("barbar").setup({
            animation = true, -- Включает анимацию при перемещении буферов
            clickable = true, -- Разрешает взаимодействие мышкой
        })

        -- Сделать фон за табами прозрачным
        vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" }) -- на всякий случай для других тем

        -- Пример: сами вкладки пусть будут светиться (например, голубым и прозрачным)
        vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#222249", bold = false })
        vim.api.nvim_set_hl(0, "BufferVisible", { bg = "#181825" })
        vim.api.nvim_set_hl(0, "BufferInactive", { bg = "none" }) -- неактивные вкладки прозрачные
        vim.api.nvim_set_hl(0, "BufferCurrentSign", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferVisibleSign", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferSign", { bg = "none" })

        -- Привязки клавиш для переключения между буферами
        vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<CR>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>bd", "<cmd>BufferClose<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "Q", "<cmd>BufferClose<CR>", { noremap = true, silent = true })
    end,
}
