return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            -- vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("catppuccin")
            -- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
            -- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
    },
    {
        "EdenEast/nightfox.nvim",
    },
    {
        "rose-pine/neovim",
        name = "rose-pine"
    },
    {
        "xiyaowong/transparent.nvim",
    },
}
