local M = {}
local api = vim.api
local cmd = vim.cmd
local keymap = vim.keymap
local buf_bind = vim.api.nvim_buf_set_keymap

-- Create an augroup
function M.create_augroup(autocmds, name, clear)
    local group = api.nvim_create_augroup(name, { clear = clear })

    for _, autocmd in ipairs(autocmds) do
        autocmd.opts.group = group
        api.nvim_create_autocmd(autocmd.event, autocmd.opts)
    end
end

-- Create an augroup variant
function M.create_augroup2(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')

    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    cmd('augroup END')
end

-- Create a buffer-local augroup
function M.create_buf_augroup(bufnr, autocmds, name, clear)
    bufnr = bufnr or 0

    for _, autocmd in ipairs(autocmds) do
        autocmd.opts.buffer = bufnr
    end

    M.create_augroup(autocmds, name, clear)
end

-- Create a buffer-local augroup alternative
function M.create_buf_augroup2(autocmds, name, bufnr)
    local buftext

    cmd('augroup ' .. name)

    if bufnr then
        buftext = string.format("<buffer=%d>", bufnr)
    else
        buftext = "<buffer>"
    end

    cmd('autocmd! * ' .. buftext)

    for _, autocmd in ipairs(autocmds) do
        cmd(string.format("autocmd %s %s %s", autocmd[1], buftext, table.concat(autocmd, ' ', 2)))
    end

    cmd('augroup END')
end



-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_navigation()
    local opts = { noremap = true, silent = true }

    buf_bind(0, 'n', 'k', 'gk', opts)
    buf_bind(0, 'n', 'j', 'gj', opts)
    buf_bind(0, 'n', '0', 'g0', opts)
    buf_bind(0, 'n', '^', 'g^', opts)
    buf_bind(0, 'n', '$', 'g$', opts)

    buf_bind(0, 'n', '<Up>', 'gk', opts)
    buf_bind(0, 'n', '<Down>', 'gj', opts)
    buf_bind(0, 'n', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'n', '<End>', 'g<End>', opts)

    buf_bind(0, 'o', 'k', 'gk', opts)
    buf_bind(0, 'o', 'j', 'gj', opts)
    buf_bind(0, 'o', '0', 'g0', opts)
    buf_bind(0, 'o', '^', 'g^', opts)
    buf_bind(0, 'o', '$', 'g$', opts)

    buf_bind(0, 'o', '<Up>', 'gk', opts)
    buf_bind(0, 'o', '<Down>', 'gj', opts)
    buf_bind(0, 'o', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'o', '<End>', 'g<End>', opts)

    buf_bind(0, 'i', '<Up>', '<C-o>gk', opts)
    buf_bind(0, 'i', '<Down>', '<C-o>gj', opts)
    buf_bind(0, 'i', '<Home>', '<C-o>g<Home>', opts)
    buf_bind(0, 'i', '<End>', '<C-o>g<End>', opts)
end

-- Remember last location in file
M.no_restore_cursor_buftypes = {
    'quickfix', 'nofile', 'help', 'terminal'
}

M.no_restore_cursor_filetypes = {
    'gitcommit', 'gitrebase'
}

function M.RestoreCursor()
    if vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line('$')
    and not vim.tbl_contains(M.no_restore_cursor_buftypes, vim.opt.buftype:get())
    and not vim.tbl_contains(M.no_restore_cursor_filetypes, vim.opt.filetype:get())
    then
        cmd('normal! g`" | zv')
    end
end

-- Automatically create missing directories before save
function M.create_file_directory_structure()
    local path = vim.fn.expand('%:p:h')

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, 'p')
    end
end

function M.bind_picker(keys, picker_name, extension_name)
    if extension_name ~= nil then
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    else
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    end
end

function M.buf_bind_picker(bufnr, keys, picker_name, extension_name)
    if extension_name ~= nil then
        vim.api.nvim_buf_set_keymap(
            bufnr, 'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    else
        vim.api.nvim_buf_set_keymap(
            bufnr, 'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    end
end


return M
