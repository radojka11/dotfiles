return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
    },
}
