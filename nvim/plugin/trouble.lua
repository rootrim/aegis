if vim.g.did_load_trouble_plugin then
  return
end
vim.g.did_load_trouble_plugin = true

require('trouble').setup()
local bind = require('user.bind').bind

bind('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics (Trouble)')
bind('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics (Trouble)')
bind('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols (Trouble)')
bind(
  'n',
  '<leader>cl',
  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  'LSP Definitions / references / ... (Trouble)'
)
bind('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', 'Location List (Trouble)')
bind('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', 'Quickfix List (Trouble)')
