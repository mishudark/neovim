local null_ls = require('null-ls')

require('null-ls').setup{
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd.with({
        env = {
            PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
        },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.code_actions.gitsigns,
}
