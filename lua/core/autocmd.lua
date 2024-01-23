vim.api.nvim_create_augroup("bufcheck", { clear = true })
vim.api.nvim_create_augroup('last_cursor_position', { clear = true })

vim.api.nvim_create_autocmd("TermOpen", { -- on each event "termopen" we can specify what we want to do
    -- we need to create a group for each autocmd make it idempotent
    group = 'bufcheck',
    pattern = "*",
    command = "startinsert"
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'last_cursor_position',
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
