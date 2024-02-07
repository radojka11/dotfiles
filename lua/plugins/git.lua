return {
    {
        "tpope/vim-fugitive"
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        --if we are in vimdiffview then keep the default mapping
                        if vim.wo.diff then return ']c' end
                        --defer execution until the function returned because this
                        --is an expression mapping. Expression mapping means that the 
                        --right mapping is a callback function but the actual return value
                        --of the callback an not the function itself.
                        --So for it to be copatible with the if above we need this.
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })
                end,
            })
        end,
    }
}
