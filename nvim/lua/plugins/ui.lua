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
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }
            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("t", "  > Restore Session", ":lua require('persistence').load()<cr>"),
                dashboard.button("g", "󰊢  > Git Status", ":Git<CR>"),
                dashboard.button("s", "  > Settings", ":Openconfig<CR>"),
                dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
            }
            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
        end
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({ disable_legacy_commands = true })
            -- use IconPickerNormal to open the ui
        end
    }
}
