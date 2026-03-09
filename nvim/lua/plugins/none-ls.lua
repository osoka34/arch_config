return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- attach_func = function(client, bufnr)
            --     if client.supports_method("textDocument/formatting") then
            --         vim.api.nvim_clear_autocmds({
            --             group = augroup,
            --             buffer = bufnr,
            --         })
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             group = augroup,
            --             buffer = bufnr,
            --             callback = function()
            --                 vim.lsp.format({ bufnr = bufnr })
            --             end,
            --         })
            --     end
            -- end
            null_ls.setup({
                -- on_attach = attach_func,

                sources = {
                    -- Форматтеры
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports,
                    -- null_ls.builtins.formatting.gci,
                    null_ls.builtins.formatting.goimports_reviser,
                    null_ls.builtins.formatting.golines,
                    null_ls.builtins.formatting.gofmt,

                    -- Форматирование Protobuf файлов с помощью buf format
                    -- null_ls.builtins.formatting.buf.with({
                    --     command = "buf",
                    --     args = { "format", "-" },
                    --     filetypes = { "proto" },
                    -- }),

                    -- Линтинг Protobuf файлов с помощью buf lint
                    -- null_ls.builtins.diagnostics.buf.with({
                    --     command = "buf",
                    --     args = { "lint", "--path", "$FILENAME" },
                    --     filetypes = { "proto" },
                    -- }),

                    -- Линтеры
                    -- null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.golangci_lint,

                    -- Другие утилиты
                    null_ls.builtins.code_actions.gomodifytags,
                    -- null_ls.builtins.code_actions.gotests,
                },

                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        -- Создаем автокоманду для форматирования перед сохранением
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    async = false,
                                    timeout_ms = 2000,
                                })
                            end,
                        })
                    end
                end,
            })

            -- Настройка горячей клавиши для форматирования
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
        end,
    },
}
