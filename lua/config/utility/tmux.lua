local keymap = vim.keymap

keymap.set('n', '<c-h>', ':TmuxNavigateLeft<cr>', {})
keymap.set('n', '<c-j>', ':TmuxNavigateDown<cr>', {})
keymap.set('n', '<c-k>', ':TmuxNavigateUp<cr>', {})
keymap.set('n', '<c-l>', ':TmuxNavigateRight<cr>', {})
