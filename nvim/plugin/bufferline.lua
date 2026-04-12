if vim.g.did_load_bufferline_plugin then
	return
end
vim.g.did_load_bufferline_plugin = true

local bind = require('user.bind').bind

local bufferline = require('bufferline')
bufferline.setup {
	options = {
		show_buffer_close_icons = false,
		indicator = { style = 'underline' },
		hover = { enabled = false },
		diagnostics = 'nvim_lsp',
	},
}

bind('n', 'gB', vim.cmd.bprevious, 'Previous Buffer')
bind('n', 'gb', vim.cmd.bnext, 'Next Buffer')
bind('n', '<leader>bn', vim.cmd.enew, 'New Buffer')
bind('n', '<leader>bw', vim.cmd.bw, 'Wipe Buffer')
bind('n', '<leader>bp', bufferline.pick, 'Bufferline Pick')
bind('n', '<leader>bc', bufferline.close_others, 'Bufferline Close Others')
bind('n', '<leader>br', function()
	bufferline.close_in_direction('right')
end, 'Bufferline Close Right')
