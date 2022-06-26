-- Tree-sitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'css',
        'norg',
        'go',
        'java',
        'python',
        'rust',
        'bash',
        'lua',
        'javascript',
        'typescript',
        'tsx',
        'solidity',
    },
    autotag = {
        enable = true
    },
    highlight = {
        enable = true,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            }
        },
    },
}
