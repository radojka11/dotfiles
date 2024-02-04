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
keymap("n", "<leader>e", ":Run<CR>", opts)
keymap("n", "<leader>r", function()
    vim.cmd(string.format("%%s/%s/%s/%s",
        vim.fn.input("Enter what you wanna replace: "),
        vim.fn.input("Enter what you want it replaced with: "),
        vim.fn.input("Press 'g' for global replace or 'gc' for selected replace: ")))
end, { desc = "Runs replace function" })
keymap("n", "<C-s>", ":w<CR>", {})
keymap('n', '<Tab>', ':bnext<CR>', opts)
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>", opts)
