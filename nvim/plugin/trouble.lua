if vim.g.did_load_trouble_plugin then
	return
end
vim.g.did_load_trouble_plugin = true

require('trouble').setup()
local bind = require('user.bind').bind

bind('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics')
bind('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics')
bind('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols')
bind('n', '<leader>xd', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', 'LSP Definitions etc.')
bind('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', 'Location List')
bind('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', 'Quickfix List')
