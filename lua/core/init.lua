require("core.options")
require("core.commands")
require("core.lazy")
require("core.remaps")
require("core.autocmd")

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
