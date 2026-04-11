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

bind('n', 'gB', vim.cmd.bprevious, 'previous [b]uffer')
bind('n', 'gb', vim.cmd.bnext, 'next [b]uffer')
bind('n', '<leader>bn', vim.cmd.enew, '[b]uffer: [n]ew')
bind('n', '<leader>bw', vim.cmd.bw, '[b]uffer: [w]ipe')
bind('n', '<leader>bp', bufferline.pick, '[b]ufferline [p]ick')
bind('n', '<leader>bc', bufferline.close_others, '[b]ufferline [c]lose others')
bind('n', '<leader>br', function()
	bufferline.close_in_direction('right')
end, '[b]ufferline close [r]ight')
