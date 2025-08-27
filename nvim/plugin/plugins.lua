if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

require('bufferline').setup()
require('hardtime').setup()
require('colorizer').setup()
require('todo-comments').setup()
