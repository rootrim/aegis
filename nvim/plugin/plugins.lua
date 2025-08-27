if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('bufferline').setup()
require('hardtime').setup()
require('copilot_cmp').setup()
require('copilot').setup {
  suggestion = { enabled = true },
  panel = { enabled = false },
}
require('colorizer').setup()
require('todo-comments').setup()
