local lsp = vim.lsp
local fn = vim.fn

require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 20,
    },
    float = {
        enabled = true,
        -- Text to show in the popup float
        text = "",
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "",
    }
}

-- Change Lightbulb sign
vim.fn.sign_define('LightBulbSign', { text = "" })

require('utils').create_augroup2({
    {'CursorHold,CursorHoldI', '*', 'lua require("nvim-lightbulb").update_lightbulb()'}
}, 'nvim-lightbulb')

require('symbols-outline').setup {
    highlight_hovered_item = true,
    show_guides = true,
}

-- Make LSP floating windows have borders
lsp.handlers["textDocument/hover"] = lsp.with(
    lsp.handlers.hover,
    { border = "single" }
)

lsp.handlers["textDocument/signatureHelp"] = lsp.with(
    lsp.handlers.signature_help,
    { border = "single" }
)

-- Diagnostics configuration
vim.diagnostic.config {
    virtual_text = true,
}

-- Diagnostic Signs
fn.sign_define('DiagnosticSignError', {text = '✗', texthl = 'DiagnosticSignError'})
fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
fn.sign_define('DiagnosticSignInfo', {text = '', texthl = 'DiagnosticSignInfo'})
fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})

vim.lsp.protocol.CompletionItemKind = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

-- Setup LSP Installer
require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { 'sumneko_lua', 'vimls', 'bashls', 'gopls' },
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- Load client configurations
require('config.lsp.clients')
require('config.lsp.trouble')
require('config.lsp.nullls')
require('cosmic-ui').setup()
