return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- treesitter
            local treesiter_config = require("nvim-treesitter.config")
            treesiter_config.setup({
                -- ensure_installed = { "lua", "go", "python", "vim", "c" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 3,
                transparent = true,
            })
        end,
    },
}
