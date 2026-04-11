if vim.g.did_load_treesitter_plugin then
	return
end
vim.g.did_load_treesitter_plugin = true

require('nvim-treesitter').setup {
	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KiB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
}

require('treesitter-context').setup {
	max_lines = 0,
	multiwindow = true,
}
