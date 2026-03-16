if vim.g.did_load_todo_plugin then
  return
end
vim.g.did_load_todo_plugin = true

-- TODO:
-- Add functionality for todo!() macro.
require('todo-comments').setup {
  keywords = {
    FIX = {
      icon = ' ',
      color = 'error',
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', '[FIXME]' },
    },
    TODO = { icon = ' ', color = 'info', alt = { '[TODO]', 'todo!()' } },
    HACK = { icon = ' ', color = 'warning', alt = { '[HACK]' } },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX', '[WARN]', '[WARNING]' } },
    PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', '[INFO]', '[NOTE]' } },
    TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
  },
  highlight = {
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = false,
  },
}
