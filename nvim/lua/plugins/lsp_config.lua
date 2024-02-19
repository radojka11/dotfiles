return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "folke/neodev.nvim",   opts = {} },
        },
        config = function()
            -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
            require("neodev").setup({})
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- see to use telescope
                vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format { async = true } end, opts)
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Change the Diagnostic symbols in the sign column (gutter)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            lspconfig["html"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["tsserver"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["cssls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["pyright"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["emmet_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "html", "typescript", "javascript", "css" },
            })
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
        end,
    },
    {
        "RRethy/vim-illuminate"
    },
}
