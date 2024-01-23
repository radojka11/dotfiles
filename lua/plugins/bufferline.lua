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
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true     -- use a "true" to enable the default, or set your own character
                    }
                }
            },
        })
    end,
}
