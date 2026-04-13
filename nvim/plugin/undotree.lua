if vim.g.did_load_undotree_plugin then
	return
end
vim.g.did_load_undotree_plugin = true

local bind = require('user.bind').bind
bind('n', '<leader>u', require('undotree').open, 'Undotree Toggle')
