if vim.g.did_load_gitsigns_plugin then
	return
end
vim.g.did_load_gitsigns_plugin = true

local bindbf = require('user.bind').bindbf

vim.schedule(function()
	require('gitsigns').setup {
		current_line_blame = true,
		current_line_blame_opts = {
			ignore_whitespace = true,
			delay = 0,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			bindbf(bufnr, 'n', '<leader>gb', gs.toggle_current_line_blame, 'Git Toggle Current Line Blame')
			bindbf(bufnr, 'n', '<leader>gd', gs.toggle_deleted, 'Git Toggle Deleted')
		end,
	}
end)
