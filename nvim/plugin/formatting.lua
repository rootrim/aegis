if vim.g.did_load_formatter_plugin then
  return
end
vim.g.did_load_formatter_plugin = true

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- rust = { "rustfmt", lsp_format = "fallback" },
  },
})
