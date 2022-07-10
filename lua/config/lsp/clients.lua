local keymap = vim.keymap
local lsputils = require('config.lsp.utils')

-- Client setup
lsputils.clients['rust_analyzer'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)
        keymap.set(
            'n', '<Leader>lR', '<cmd>CargoReload<CR>',
            { silent = true, buffer = bufnr }
        )
    end,
    settings = {
        ['rust-analyzer'] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}

lsputils.clients['sumneko_lua'].setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    }
}

lsputils.clients['pyright'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)
        keymap.set(
            'n', '<Leader>lo', '<cmd>PyrightOrganizeImports<CR>',
            { silent = true, buffer = bufnr }
        )
    end
}

lsputils.clients['bashls'].setup {}

lsputils.clients['gopls'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)
    end
}


require("typescript").setup({
    disable_commands = false,
    debug = false,
    server = {
        on_attach = function(client, bufnr)
            lsputils.default_on_attach(client, bufnr)
            keymap.set(
                'n', '<Leader>oi', '<cmd>TypescriptOrganizeImports<CR>',
                { silent = true, buffer = bufnr }
            )
            keymap.set(
                'n', '<Leader>un', '<cmd>TypescriptRemoveUnused<CR>',
                { silent = true, buffer = bufnr }
            )

        end
    },
})

lsputils.clients['solidity_ls'].setup {}
