return {
    {
        "hrsh7th/nvim-cmp",                 -- this is just for autocompletion but it does not know what to complete.
        event = "InsertEnter",              -- for that we need sources for cmp to know.
        dependencies = {
            { "hrsh7th/cmp-buffer" },       -- source for text in buffer
            { "hrsh7th/cmp-path" },         -- course for file system paths
            -- { "L3MON4D3/LuaSnip" },         -- just an engine that we can create snippets with. Nothing to do with cmp
            { "saadparwaiz1/cmp_luasnip" }, -- this is so that we can load our snippets from luasnip into cmp.
            { "onsails/lspkind.nvim" },     -- for asthetics
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require('lspkind')
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                completion = {
                    completeopt = "menu,menuone,preview,noselect"
                },
                snippet = {                                      --how cmp interacts with a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- when a snippet is selected, call the snippet.
                        -- the snippet is contained in the args.body. This argument gets passed over from
                        -- the cmp to the function that actually expands the snippet.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" },  -- text within current buffer
                    { name = "path" },    -- file system paths
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text', -- show symbol annotations and text
                    })
                },
            })
            vim.cmd("highlight FloatBorder guibg=NONE")
        end,
    },

}
