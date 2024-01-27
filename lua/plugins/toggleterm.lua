return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            vim.keymap.set("n", "<leader>tt", function()
                vim.cmd(":ToggleTerm direction=float")
                if vim.bo.filetype == "toggleterm" then
                   vim.cmd("startinsert")
                end
            end, opts)
        })
    end,
}
