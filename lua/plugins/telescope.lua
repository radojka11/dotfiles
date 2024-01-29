local keymap = vim.keymap.set
local opts = { noremap = true, silent = true } -- no recursive mappings and dont produce an output

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")
        keymap("n", "<leader>ff", builtin.find_files, { desc = "find files in the current work directory" })   -- lists files in the current working directory
        keymap("n", "<leader>fg", builtin.live_grep, { desc = "grep the working directory" })                  -- search for a string in the current working dir
        keymap("n", "<leader>fb", builtin.buffers, { desc = "search for the current open buffers" })
        keymap("n", "<leader>ft", builtin.colorscheme, { desc = "search for a theme" })
        keymap("n", "<leader>fr", builtin.registers, { desc = "search the registers" })
        keymap("n", "<leader>fm", builtin.keymaps, { desc = "show all keymaps" })
        keymap("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "grep current file" })
        keymap("n", "<leader>fo", builtin.oldfiles, { desc = "search old files" })
    end,
}
