if vim.g.did_load_crates_plugin then
	return
end
vim.g.did_load_crates_plugin = true

vim.api.nvim_create_autocmd('BufEnter', {
	pattern = 'Cargo.toml',
	callback = function(args)
		local bufnr = args.buf
		local crates = require('crates')
		crates.setup {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				crates = {
					enabled = true,
					max_results = 8,
					min_chars = 3,
				},
			},
		}

		local bindbf = require('user.bind').bindbf
		bindbf(bufnr, 'n', '<leader>ct', crates.toggle, 'Crates Toggle')
		bindbf(bufnr, 'n', '<leader>cr', crates.reload, 'Crates Reload')

		bindbf(bufnr, 'n', '<leader>cv', crates.show_versions_popup, 'Crates Show Versions')
		bindbf(bufnr, 'n', '<leader>cf', crates.show_features_popup, 'Crates Show Features')
		bindbf(bufnr, 'n', '<leader>cd', crates.show_dependencies_popup, 'Crates Show Dependencies')

		bindbf(bufnr, 'n', '<leader>cu', crates.update_crate, 'Crates Update Crate')
		bindbf(bufnr, 'v', '<leader>cu', crates.update_crates, 'Crates Update Crates')
		bindbf(bufnr, 'n', '<leader>ca', crates.update_all_crates, 'Crates Update All Crates')
		bindbf(bufnr, 'n', '<leader>cU', crates.upgrade_crate, 'Crates Upgrade Crate')
		bindbf(bufnr, 'v', '<leader>cU', crates.upgrade_crates, 'Crates Upgrade Crates')
		bindbf(bufnr, 'n', '<leader>cA', crates.upgrade_all_crates, 'Crates Upgrade All Crates')

		bindbf(bufnr, 'n', '<leader>cx', crates.expand_plain_crate_to_inline_table, 'Crates Expand Crate To Table')
		bindbf(bufnr, 'n', '<leader>cX', crates.extract_crate_into_table, 'Crates Extract Crate Into Table')

		bindbf(bufnr, 'n', '<leader>cH', crates.open_homepage, 'Crates Open Homepage')
		bindbf(bufnr, 'n', '<leader>cR', crates.open_repository, 'Crates Open Repository')
		bindbf(bufnr, 'n', '<leader>cD', crates.open_documentation, 'Crates Open Documentation')
		bindbf(bufnr, 'n', '<leader>cC', crates.open_crates_io, 'Crates Open crates.io')
		bindbf(bufnr, 'n', '<leader>cL', crates.open_lib_rs, 'Open lib.rs')
	end,
})
