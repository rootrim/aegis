if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      gs.toggle_current_line_blame()

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[g]it toggle current [l]ine [b]lame' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'git [t]oggle [d]eleted' })
    end,
  }
end)
