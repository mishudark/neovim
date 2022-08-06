-- Plugins
local packer = require('packer')
local use = packer.use

packer.reset()
packer.init {
    git = {
        clone_timeout = -1
    }
}

-- Tree navigation
use 'kyazdani42/nvim-tree.lua'

-- Neovim package manager
use 'wbthomason/packer.nvim'

-- Load Lua modules faster
use 'lewis6991/impatient.nvim'

-- Colorscheme
use 'Mofiqul/vscode.nvim'
use 'olimorris/onedarkpro.nvim'

-- Tmux split navigation
use 'christoomey/vim-tmux-navigator'

-- Git
use 'tpope/vim-fugitive'
use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

-- Surround
use 'tpope/vim-surround'

-- Automatically detect indentation
use 'tpope/vim-sleuth'

-- Comments
use 'b3nj5m1n/kommentary'

-- Delimit characters automatically
use 'windwp/nvim-autopairs'

-- Project management
use 'ahmedkhalf/project.nvim'

-- LSP
use 'neovim/nvim-lspconfig'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'folke/trouble.nvim'
use 'jose-elias-alvarez/typescript.nvim'
use 'jose-elias-alvarez/null-ls.nvim'
use 'Maan2003/lsp_lines.nvim'
use 'CosmicNvim/cosmic-ui'

-- Go
use 'fatih/vim-go'

-- navigation
use 'ggandor/leap.nvim'

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
}
use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use { 'nvim-telescope/telescope-ui-select.nvim' }
use { "nvim-telescope/telescope-file-browser.nvim" }

-- Better quickfix window
use 'kevinhwang91/nvim-bqf'

-- Completion and snippets
use 'L3MON4D3/LuaSnip'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lua'

-- Tresitter
use 'nvim-treesitter/nvim-treesitter'
use 'nvim-treesitter/nvim-treesitter-context'
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'SmiteshP/nvim-gps'
use 'windwp/nvim-ts-autotag'

-- Org
use {
    'wthollingsworth/pomodoro.nvim',
    requires = 'MunifTanjim/nui.nvim',
}

-- Tools
use { 'feline-nvim/feline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
use 'famiu/bufdelete.nvim'
use 'rcarriga/nvim-notify'
