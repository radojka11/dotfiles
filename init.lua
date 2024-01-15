-- :h <anything>   shows the help page of anything like commands
-- :options    shows all the options we can set 

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }  -- no recursive mappings and dont produce an output

if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))', 
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))', 
        },
        cache_enabled = 0,
    }
end

-- OPTIONS --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999
vim.opt.mouse = "a"
vim.opt.showtabline = 2
vim.g.transparent_enabled = true
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"  -- show preview window
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.showmode = false
-- the leader key allows for keymaps that dont conflict with vims default keybindings
vim.g.mapleader = " " 
vim.g.maplocalleader = " "

-- PLUGINS --

-- vim.fn is a way to interface with the native vimscript
-- .. is is lua concat operator
-- so basically lazy is installing itself to our data dir
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- vim.fn is calling vimscript functions
if not vim.loop.fs_stat(lazypath) then  -- checks if lazy already is there
    vim.fn.system({  --vimscript command
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)  -- rtp is the runtimepath where neovim will look for plugins
-- the : operator just puts the output back into the first parameter

require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()                      --lazy provides a callback that we can implement called config.
                                                 -- with this callback we can do configs specific to plugins.
                                                 -- but because the whole init.lua is async in nature, to guarantee that the plugin
            --vim.cmd.colorscheme("kanagawa-wave") --instead running the vim command each time to set a colorscheme we will always run the command here at start
                                                 -- specific commands will be called AFTER the plugin itself was installed, we need
                                                 -- to do the config in this callback that will make sure it is called only after the
                                                 -- plugin install is done. This prevents race conditions by ensuring proper order of execution
        end,
    },
    {
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "cpp", "css", "java", "javascript", "python", "html"},
                auto_install = true,
                highlight = {
                    enable = true,
                },
            })
        end, 
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("lualine").setup({
                -- sections = {
                --     lualine_x = {'branch', 'diff', 'diagnostics'},
                -- },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim", 
        config = function()
            require("indent_blankline").setup()
        end,
    },
    {
        "numToString/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup({
                toggler = {
                    line = "<leader>c",
                },
                opleader = {
                    line = "<leader>c",
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("telescope").setup()
            local builtin = require("telescope.builtin")
            keymap("n", "<leader>ff", builtin.find_files, {}) -- lists files in the current working directory
            keymap("n", "<leader>fg", builtin.live_grep, {}) -- search for a string in the current working dir
            keymap("n", "<leader>fb", builtin.buffers, {})
            keymap("n", "<leader>ft", builtin.colorscheme, {})
            keymap("n", "<leader>fr", builtin.registers, {})
            keymap("n", "<leader>fm", builtin.keymaps, {})
            keymap("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
        end,
    }, 
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", 
          "MunifTanjim/nui.nvim",
        },
        config = function()
            keymap("n", "<leader>n", ":Neotree toggle<CR>", opts)
            vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
        end,
    },
    {
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
                            separator = true -- use a "true" to enable the default, or set your own character
                        }
                    }
                },
                
            })
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup({})
        end,
            
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "pyright"}
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            keymap("n", "K", vim.lsp.buf.hover, {}) -- in vim, shift + k displays the man page of the word under curson
            keymap("n", "gd", vim.lsp.buf.definition, {})
        end,
    },
})-- neovim will look for the init.lua file of lazy and run its setup func with specific plugins


replace = function() 
    vim.cmd(string.format("%%s/%s/%s/%s", 
    vim.fn.input("Enter what you wanna replace: "), 
    vim.fn.input("Enter what you want it replaced with: "), 
    vim.fn.input("Press 'g' for global replace or 'gc' for selected replace: "))) end

--custom commands
vim.api.nvim_create_user_command("Openconfig", function()
    vim.cmd([[:edit ~/.config/nvim/init.lua]])
end, {})
-- splits
keymap("n", "<leader>l", "<C-w>l", opts)
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
-- use the :close command to close the current window
keymap("t", "<esc>", [[<C-\><C-n>]], opts) -- the [[]] means raw string in lua, this is used to exit terminal mode
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>tv", ":vsplit | terminal<CR>", opts)
keymap("n", "<leader>th", ":split | terminal<CR>", opts)
-- general mappings
keymap("n", "<leader>r", replace, {desc = "Runs replace function"})
keymap("n", "<C-s>", ":w<CR>", {})
-- use :bd to close the current buffer
-- buffers
keymap('n', '<Tab>', ':bnext<CR>', opts)
-- lsp mappings



