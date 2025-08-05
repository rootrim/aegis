if vim.g.did_load_neotree_plugin then
  return
end
vim.g.did_load_neotree_plugin = true

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle float<CR>', { desc = 'Toggle neotree (float)'})


