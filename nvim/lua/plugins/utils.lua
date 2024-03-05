keymap = vim.keymap.set
opts = { noremap = true, silent = true } -- no recursive mappings and dont produce an output

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            keymap("n", "<leader>ff", builtin.find_files, { desc = "find files in the current work directory" }) -- lists files in the current working directory
            keymap("n", "<leader>fg", builtin.live_grep, { desc = "grep the working directory" })                -- search for a string in the current working dir
            keymap("n", "<leader>fb", builtin.buffers, { desc = "search for the current open buffers" })
            keymap("n", "<leader>ft", builtin.colorscheme, { desc = "search for a theme" })
            keymap("n", "<leader>fr", builtin.registers, { desc = "search the registers" })
            keymap("n", "<leader>fm", builtin.keymaps, { desc = "show all keymaps" })
            keymap("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "grep current file" })
            keymap("n", "<leader>fo", builtin.oldfiles, { desc = "search old files" })
            vim.cmd("highlight TelescopeBorder guibg=NONE")
            vim.cmd("highlight TelescopeNormal guibg=NONE")
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local oil = require("oil")
            oil.setup({
                delete_to_trash = false,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        return vim.startswith(name, ".")
                    end,
                }
            })
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
        config = function()
            require("persistence").setup({
                dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
                options = { "buffers", "curdir", "tabpages", "winsize" }
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },
    {
        "mbbill/undotree"
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1500
        end,
        opts = {
        }
    }
}
