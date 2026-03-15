if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local api = vim.api
local fn = vim.fn
local bind = require('user.bind').bind
local bindbf = require('user.bind').bindbf

-- Yank from current position till end of current line
bind('n', 'Y', 'y$', '[Y]ank to end of line')

-- Buffer list navigation
bind('n', '[b', '<cmd>bprevious<cr>', 'previous [b]uffer')
bind('n', ']b', '<cmd>bnext<cr>', 'next [b]uffer')
bind('n', '[B', '<cmd>bfirst<cr>', 'first [B]uffer')
bind('n', ']B', '<cmd>blast<cr>', 'last [B]uffer')

-- Undo tree
bind('n', '<leader>U', '<cmd>UndotreeToggle<cr>', '[U]ndo tree toggle')

-- Toggle the quickfix list (only opens if it is populated)
local function toggle_qf_list()
  local qf_exists = false
  for _, win in pairs(fn.getwininfo() or {}) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd.cclose()
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end

bind('n', '<C-c>', toggle_qf_list, 'toggle quickfix list')

local function try_fallback_notify(opts)
  local success, _ = pcall(opts.try)
  if success then
    return
  end
  success, _ = pcall(opts.fallback)
  if success then
    return
  end
  vim.notify(opts.notify, vim.log.levels.INFO)
end

-- Cycle the quickfix and location lists
local function cleft()
  try_fallback_notify {
    try = vim.cmd.cprev,
    fallback = vim.cmd.clast,
    notify = 'Quickfix list is empty!',
  }
end

local function cright()
  try_fallback_notify {
    try = vim.cmd.cnext,
    fallback = vim.cmd.cfirst,
    notify = 'Quickfix list is empty!',
  }
end

bind('n', '[c', cleft, '[c]ycle quickfix left')
bind('n', ']c', cright, '[c]ycle quickfix right')
bind('n', '[C', vim.cmd.cfirst, 'first quickfix entry')
bind('n', ']C', vim.cmd.clast, 'last quickfix entry')

local function lleft()
  try_fallback_notify {
    try = vim.cmd.lprev,
    fallback = vim.cmd.llast,
    notify = 'Location list is empty!',
  }
end

local function lright()
  try_fallback_notify {
    try = vim.cmd.lnext,
    fallback = vim.cmd.lfirst,
    notify = 'Location list is empty!',
  }
end

bind('n', '[l', lleft, 'cycle [l]oclist left')
bind('n', ']l', lright, 'cycle [l]oclist right')
bind('n', '[L', vim.cmd.lfirst, 'first [L]oclist entry')
bind('n', ']L', vim.cmd.llast, 'last [L]oclist entry')

-- Resize vertical splits
local toIntegral = math.ceil
bind('n', '<leader>w+', function()
  local curWinWidth = api.nvim_win_get_width(0)
  api.nvim_win_set_width(0, toIntegral(curWinWidth * 3 / 2))
end, 'inc window [w]idth')
bind('n', '<leader>w-', function()
  local curWinWidth = api.nvim_win_get_width(0)
  api.nvim_win_set_width(0, toIntegral(curWinWidth * 2 / 3))
end, 'dec window [w]idth')
bind('n', '<leader>h+', function()
  local curWinHeight = api.nvim_win_get_height(0)
  api.nvim_win_set_height(0, toIntegral(curWinHeight * 3 / 2))
end, 'inc window [h]eight')
bind('n', '<leader>h-', function()
  local curWinHeight = api.nvim_win_get_height(0)
  api.nvim_win_set_height(0, toIntegral(curWinHeight * 2 / 3))
end, 'dec window [h]eight')

-- Remap Esc to switch to normal mode and Ctrl-Esc to pass Esc to terminal
bind('t', '<Esc>', '<C-\\><C-n>', 'switch to normal mode')
bind('t', '<C-Esc>', '<Esc>', 'send Esc to terminal')

-- Shortcut for expanding to current buffer's directory in command mode
bind('c', '%%', function()
  if fn.getcmdtype() == ':' then
    return fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, "expand to current buffer's directory", { expr = true })

bind('n', '<leader>tn', vim.cmd.tabnew, '[t]ab: [n]ew')
bind('n', '<leader>tq', vim.cmd.tabclose, '[t]ab: [q]uit/close')

bind('n', '<C-d>', '<C-d>zz', 'move [d]own half-page and center')
bind('n', '<C-u>', '<C-u>zz', 'move [u]p half-page and center')
bind('n', '<C-f>', '<C-f>zz', 'move DOWN [f]ull-page and center')
bind('n', '<C-b>', '<C-b>zz', 'move UP full-page and center')

api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    bindbf(event.buf, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'LSP: hover')
    bindbf(event.buf, 'n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>', 'LSP: references')
    bindbf(event.buf, 'n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'LSP: implementation')
    bindbf(event.buf, 'n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', 'LSP: rename')
    bindbf(event.buf, 'n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'LSP: code action')
    bindbf(event.buf, 'n', 'grt', '<cmd>lua vim.lsp.buf.definition()<cr>', 'LSP: code definition')
    bindbf(event.buf, 'n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', 'LSP: document symbol')
    bindbf(event.buf, { 'i', 's' }, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'LSP: signature help')
  end,
})
