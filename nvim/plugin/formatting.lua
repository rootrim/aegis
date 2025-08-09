if vim.g.did_load_formatter_plugin then
  return
end
vim.g.did_load_formatter_plugin = true

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- rust = { "rustfmt", lsp_format = "fallback" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}
