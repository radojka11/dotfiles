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

if vim.fn.execute("!dpkg -l | grep ripgrep") == "nil" then
    print("ripgrep is not installed on the system, installing...")
    vim.fn.execute("sudo apt-get install ripgrep")
    print("ripgrep installed")
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
vim.opt.updatetime = 50
vim.opt.colorcolumn = "90"
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
                ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "cpp", "css", "java", "javascript", "python", "html", "robot"},
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
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup({
                mappings = {
                    basic = true,
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
            keymap("n", "<leader>ff", builtin.find_files, {desc = "find files in the current work directory"}) -- lists files in the current working directory
            keymap("n", "<leader>fg", builtin.live_grep, {desc = "grep the working directory"}) -- search for a string in the current working dir
            keymap("n", "<leader>fb", builtin.buffers, {desc = "search for the current open buffers"})
            keymap("n", "<leader>ft", builtin.colorscheme, {desc = "search for a theme" })
            keymap("n", "<leader>fr", builtin.registers, {desc = "search the registers"})
            keymap("n", "<leader>fm", builtin.keymaps, {desc = "show all keymaps"})
            keymap("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {desc = "grep current file"})
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
                ensure_installed = {"lua_ls", "pyright", "robotframework_ls"}
            })
        end,
    },

    { 
        "ellisonleao/gruvbox.nvim", 
        priority = 1000, 
        config = true, 
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
        end,
        opts = {

        },
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require'cmp'
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                  -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              -- { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })
    end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
            })
            lspconfig.pyright.setup({
            })
            lspconfig.robotframework_ls.setup({
            })
            keymap("n", "K", vim.lsp.buf.hover, {}) -- in vim, shift + k displays the man page of the word under curson
            keymap("n", "gd", vim.lsp.buf.definition, {})
            keymap("n", "od", vim.diagnostic.open_float, {})
        end,
    },
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*",
    --     event = "VeryLazy",
    --     config = function()
    --         require("nvim-surround").setup({
    --         })
    --     end
    -- }
})

vim.api.nvim_create_user_command("Openhtml", function()
    vim.fn.system("xdg-open" .. " " .. vim.fn.expand("<cfile>"))
end, {})

-- Enter insert mode when opening a terminal.
vim.api.nvim_create_autocmd("TermOpen", {   -- on each event "termopen" we can specify what we want to do
    -- we need to create a group for each autocmd make it idempotent
    group = vim.api.nvim_create_augroup("MyGroup", {clear = true}),
    pattern = "*",
    command = "startinsert"
})

keymap("n", "<leader>e", function()  -- todo: make generic and easyly extensible
    local filetype = vim.api.nvim_exec("echo &filetype", true)
    if filetype == "python" then
        vim.cmd("vsp | terminal python3 %")
    elseif filetype == "java" then
        vim.cmd("vsp | terminal java %")
    end
end, opts)


vim.api.nvim_create_user_command("Ud", function()
--[[
:w under the hood just writes the current contents of the buffer to the file. However if we put a shell command after it 
then the contents of the file get written to stdin and therefore not actually saved.
diff then also takes in as arg the current file path since % is the register that holds the current file path string
- means that the diff command just reads the stdin as the second file
--]]
    vim.cmd(":w !diff % -")
end, {})

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
keymap("n", "<leader>r", function()
    vim.cmd(string.format("%%s/%s/%s/%s",
    vim.fn.input("Enter what you wanna replace: "),
    vim.fn.input("Enter what you want it replaced with: "),
    vim.fn.input("Press 'g' for global replace or 'gc' for selected replace: "))) end, {desc = "Runs replace function"})
keymap("n", "<C-s>", ":w<CR>", {})
-- use :bd to close the current buffer
-- buffers
keymap('n', '<Tab>', ':bnext<CR>', opts)
-- lsp mappings

-- TODO
-- autocompletion
-- snippets
-- debugging
-- undo tree
-- git integration
-- refactor config








