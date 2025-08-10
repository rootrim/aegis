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
local hipatterns = require('mini.hipatterns')
hipatterns.setup {
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}

local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<CR>', { 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })
