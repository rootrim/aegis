if vim.g.did_load_flutter_plugin then
	return
end
vim.g.did_load_flutter_plugin = true

require('flutter-tools').setup {}
