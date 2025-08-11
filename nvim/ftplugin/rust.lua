local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<leader>ca', function()
  vim.cmd.RustLsp('codeAction')
  -- or vim.lsp.buf.codeAction()
end, { desc = '[C]ode [A]ction', silent = true, buffer = bufnr })
vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp { 'hover', 'actions' }
end, { silent = true, buffer = bufnr })
