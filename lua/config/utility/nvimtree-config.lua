require("nvim-tree").setup()
local keymap = vim.keymap

keymap.set('n', ',d', '<cmd>NvimTreeToggle<cr>', {})
