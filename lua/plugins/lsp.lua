return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "jay-babu/mason-nvim-dap.nvim" },
        { "folke/neodev.nvim",                opts = {} },
        { "onsails/lspkind.nvim" },
        { "RRethy/vim-illuminate" },

        -- null-ls
        { "nvimtools/none-ls.nvim" },
        { "jay-babu/mason-null-ls.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            version = "2.*",
            dependencies = { "rafamadriz/friendly-snippets" }
        },
    },
    config = function()
        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        require("neodev").setup({})
        local lsp_zero = require('lsp-zero')
        require("luasnip.loaders.from_vscode").lazy_load()
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require('mason').setup({
            opts = {
                ensure_installed = {
                    "pyright",
                    "debugpy",
                    "lua_ls",
                    "shfmt",
                }
            }
        })
        require('mason-lspconfig').setup({
            handlers = {
                lsp_zero.default_setup,
            }
        })
        local lspkind = require('lspkind')
        local cmp = require("cmp")
        cmp.setup {
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                })
            }
        }
    end,
}
