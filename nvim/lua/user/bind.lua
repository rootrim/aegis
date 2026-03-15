---@mod user.bind
---
---@brief [[
---Binding related functions
---@brief ]]

local M = {}

function M.bind(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.silent = true
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.bindbf(bufnr, mode, l, r, desc, opts)
  opts = opts or {}
  opts.buffer = bufnr
  M.bind(mode, l, r, desc, opts)
end

return M
