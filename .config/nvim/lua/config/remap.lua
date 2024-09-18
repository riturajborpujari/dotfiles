local builtin = require("telescope.builtin")

vim.g.mapleader = " "
vim.keymap.set("n", "gwv", vim.cmd.Ex)
vim.keymap.set("n", "gf", builtin.find_files, {})
vim.keymap.set('n', 'gb', ":ls<cr>:b ")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]])

vim.keymap.set('v', '<C-n>', ":m '>+1<cr>gv=gv")
vim.keymap.set('v', '<C-p>', ":m '<-2<cr>gv=gv")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, opts)
    vim.keymap.set('n', 'gws', builtin.lsp_dynamic_workspace_symbols, {})
    vim.keymap.set('n', 'gh', builtin.lsp_references, opts) 
    vim.keymap.set('n', 'gp', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.keymap.set('i', '<Tab>', '<Tab>', opts)
  end
})

vim.api.nvim_create_autocmd("Filetype", {
  callback = function(ev) 
    if ev.match == 'c' then 
      vim.cmd("set formatprg=clang-format")
    else if ev.match == 'json' then
        vim.cmd("set formatprg=json_pp")
      end
    end
  end
})

