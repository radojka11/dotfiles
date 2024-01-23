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

vim.api.nvim_create_user_command("Openhtml", function()
    vim.fn.system("xdg-open" .. " " .. vim.fn.expand("<cfile>"))
end, {})


local run_commands = {
    python = "python3 %",
    java = "java %",

}

vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.api.nvim_exec("echo &filetype", true)
    for file, command in pairs(run_commands) do
        if filetype == file then
            vim.cmd("vsp | terminal " .. command)
            break
        end
    end
end, {})
