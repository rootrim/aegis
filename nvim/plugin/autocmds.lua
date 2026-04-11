if vim.g.did_load_autocmds_plugin then
	return
end
vim.g.did_load_autocmds_plugin = true

vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd('normal! zz')
			end)
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'help',
	command = 'wincmd L',
})

vim.api.nvim_create_autocmd('VimResized', {
	command = 'wincmd =',
})
