if vim.g.did_load_colorizer_plugin then
  return
end
vim.g.did_load_colorizer_plugin = true

require('colorizer').setup()
