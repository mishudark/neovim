-- Colorscheme options
vim.opt.background = 'dark'
vim.g.vscode_style = 'dark'
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = false

-- Set colorscheme
vim.cmd('colorscheme onedark')

-- Load UI modules
require('config.ui.feline')
require('config.ui.tabline')
require('config.ui.gitsigns')
