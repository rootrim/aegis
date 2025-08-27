if vim.g.did_load_mini_plugin then
  return
end
vim.g.did_load_mini_plugin = true

require('mini.basics').setup { mappings = { windows = true } }
require('mini.comment').setup()
require('mini.ai').setup()
require('mini.move').setup()
require('mini.keymap').setup()
require('mini.pairs').setup()
require('mini.icons').setup()
require('mini.extra').setup()
require('mini.cursorword').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()

local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<CR>', { 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })
