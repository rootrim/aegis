---@mod user.lsp
---
---@brief [[
---LSP related functions
---@brief ]]

local M = {}

---Gets a 'ClientCapabilities' object, describing the LSP client capabilities
---Extends the object with capabilities provided by plugins.
---@return lsp.ClientCapabilities
function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink_capabilities = require('blink.cmp').get_lsp_capabilities({}, false)
  capabilities = vim.tbl_deep_extend('force', capabilities, blink_capabilities)
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  })
  return capabilities
end

function M.enable_and_config(server, config)
  vim.lsp.enable(server)
  config['capabilities'] = M.make_client_capabilities()
  vim.lsp.config(server, config)
end

return M
