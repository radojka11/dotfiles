return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup()
        vim.cmd("highlight TroubleNormal guibg=NONE<CR>")
    end,
    opts = {

    },
}
