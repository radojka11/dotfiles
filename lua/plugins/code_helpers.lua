return {
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
    }
}
