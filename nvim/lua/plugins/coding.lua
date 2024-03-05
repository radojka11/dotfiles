return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "lua_ls",
                    "emmet_ls",
                    "pyright",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup({
                mappings = {
                    basic = true,
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            local ufo = require("ufo")
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            --za to toggle folds
            vim.api.nvim_create_user_command("Foldall", ufo.closeAllFolds, {})
            vim.api.nvim_create_user_command("Unfoldall", ufo.openAllFolds, {})
            ufo.setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'lsp', 'indent' }
                end
            })
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set('n', '<leader>g', '<Plug>(leap-forward)')
            vim.keymap.set('n', '<leader>G', '<Plug>(leap-backward)')
        end,
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({})
            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
            vim.cmd("highlight TroubleNormal guibg=NONE<CR>")
        end,
        opts = {

        },
    },
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
