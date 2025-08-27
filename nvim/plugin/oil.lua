if vim.g.did_load_oil_plugin then
  return
end
vim.g.did_load_oil_plugin = true
require('oil').setup()

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
