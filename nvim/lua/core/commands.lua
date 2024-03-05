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
