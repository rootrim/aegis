if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

local bindbf = require('user.bind').bindbf

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
      ignore_whitespace = true,
      delay = 0,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      bindbf(bufnr, 'n', '<leader>tb', gs.toggle_current_line_blame, '[g]it toggle current [l]ine [b]lame')
      bindbf(bufnr, 'n', '<leader>td', gs.toggle_deleted, 'git [t]oggle [d]eleted')
    end,
  }
end)
