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
        config = function()
            -- vim.cmd.colorscheme("catppuccin")
            -- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1500,
        opts = {},
        config = function()
            require("tokyonight").setup({
                transparent = true,
            })
            vim.cmd.colorscheme("tokyonight-night")
            -- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
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