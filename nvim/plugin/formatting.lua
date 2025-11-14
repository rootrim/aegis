if vim.g.did_load_formatter_plugin then
  return
end
vim.g.did_load_formatter_plugin = true

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    nix = { 'nixfmt' },
    html = { 'prettier' },
    zig = { 'zigfmt' },
    sh = { 'shfmt' },
    fish = { 'fish_indent' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}
