local lsp = vim.lsp
local fn = vim.fn

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
    virtual_text = false,
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
require("nvim-lsp-installer").setup {
    ensure_installed = { 'sumneko_lua', 'vimls', 'bashls' },
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
require("lsp_lines").register_lsp_virtual_lines()
require('cosmic-ui').setup()
