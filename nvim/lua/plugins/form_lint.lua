return {
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            require("conform").setup({
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "black" },
                    -- Use a sub-list to run only the first available formatter
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                markdown = { 'vale' },
                python = { "pylint" }
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
