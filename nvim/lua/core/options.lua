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
    -- colorcolumn = "90",
}

for option, value in pairs(options) do
    vim.opt[option] = value
end
