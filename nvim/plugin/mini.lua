if vim.g.did_load_mini_plugin then
  return
end
vim.g.did_load_mini_plugin = true

require('mini.basics').setup { mappings = { windows = true } }
require('mini.comment').setup()
require('mini.ai').setup()
require('mini.move').setup()
require('mini.keymap').setup()
