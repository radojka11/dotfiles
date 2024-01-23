local keymap = vim.keymap.set
local opts = { noremap = true, silent = true } -- no recursive mappings and dont produce an output

return {
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
}
