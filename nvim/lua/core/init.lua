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

vim.opt.fillchars = { eob = " " }                 -- hide the tildes from vanilla vim
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- this stuff is probably not needed
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.cmd("set foldcolumn=0")                       -- disable the column that shows folds, looks fugly

--OPTIONS
vim.g.have_nerd_font = true

local options = {
    number = true,
    relativenumber = true,
    splitbelow = true,
    expandtab = true,
    splitright = true,
    wrap = false,
    tabstop = 4,
    shiftwidth = 4,
    clipboard = "unnamedplus",
    scrolloff = 999,
    mouse = "a",
    showtabline = 2,
    virtualedit = "block",
    inccommand = "split",
    ignorecase = true,
    termguicolors = true,
    showmode = false,
    updatetime = 50,
    timeoutlen = 300,
    -- colorcolumn = "90",
}

for option, value in pairs(options) do
    vim.opt[option] = value
end

keymap = vim.keymap.set
opts = { noremap = true, silent = true } -- no recursive mappings and dont produce an output

-- splits
keymap("n", "<leader>l", "<C-w>l", opts)
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("t", "<esc>", [[<C-\><C-n>]], opts) -- the [[]] means raw string in lua, this is used to exit terminal mode
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>tv", ":vsplit | terminal<CR>", opts)
keymap("n", "<leader>th", ":split | terminal<CR>", opts)
-- general mappings
keymap("n", "<leader>e", ":w | Run<CR>", opts)
keymap("n", "<leader>r", function()
    vim.cmd(string.format("%%s/%s/%s/%s",
        vim.fn.input("Enter what you wanna replace: "),
        vim.fn.input("Enter what you want it replaced with: "),
        vim.fn.input("Press 'g' for global replace or 'gc' for selected replace: ")))
end, { desc = "Runs replace function" })
keymap("n", "<C-s>", ":w<CR>", {})
keymap('n', '<tab>', ':bnext<cr>', opts)
keymap('n', '<S-tab>', ':bprevious<cr>', opts)
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>", opts)
keymap("n", "<leader>n", ":Neotree position=float toggle<CR>", opts)

--COMMANDS
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
    vim.cmd([[:Neotree dir=~/.config/nvim position=float]])
end, {})

vim.api.nvim_create_user_command("Openhtml", function()
    vim.fn.system("xdg-open" .. " " .. vim.fn.expand("<cfile>"))
end, {})


local run_commands = {
    python = "python3 %",
    java = "java %",

}

vim.api.nvim_create_user_command("Run", function()
    for file, command in pairs(run_commands) do
        if vim.bo.filetype == file then
            vim.cmd("vsp | terminal " .. command)
            break
        end
    end
end, {})

--autocmd's
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("TermOpen", { -- on each event "termopen" we can specify what we want to do
    -- we need to create a group for each autocmd make it idempotent
    group = vim.api.nvim_create_augroup("bufcheck", { clear = true }),
    pattern = "*",
    command = "startinsert"
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('last_cursor_position', { clear = true }),
    pattern = '*',
    --[[
the '" is a vimscript thing that stores the last cursor position line number.
the $ represents the last line in
the if is basically as safe guard for three things:
1. if the position was one then avoid redundancy operations
2. avoid error if the file has been shrinked since last open
3. dont do this for commit messages
--]]
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") and not vim.bo.filetype:match('commit') then
            vim.api.nvim_exec("normal! g`\"zvzz", false)
        end
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
