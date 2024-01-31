return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({

            options = {
                style_preset = bufferline.style_preset.minimal,
                offsets = {
                    {
                        -- filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true -- use a "true" to enable the default, or set your own character
                    }
                }
            },
        })
        vim.g.transparent_groups = vim.list_extend(
            vim.g.transparent_groups or {},
            vim.tbl_map(function(v)
                return v.hl_group
            end, vim.tbl_values(require('bufferline.config').highlights))
        )
    end,
}
