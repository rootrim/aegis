if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local actions = require('telescope.actions')

local builtin = require('telescope.builtin')

local layout_config = {
  vertical = {
    width = function(_, max_columns)
      return math.floor(max_columns * 0.5)
    end,
    height = function(_, _, max_lines)
      return math.floor(max_lines * 0.7)
    end,
    prompt_position = 'bottom',
    preview_cutoff = 0,
  },
}

-- Fall back to find_files if not in a git repo
local project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

vim.keymap.set('n', '<leader>fp', builtin.oldfiles, { desc = '[f]ind [p]revious files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind words (live [g]rep)' })
vim.keymap.set('n', '<leader>ff', project_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = '[f]ind [q]uickfix list' })
vim.keymap.set('n', '<leader>fh', builtin.command_history, { desc = '[f]ind command [h]istory' })
vim.keymap.set('n', '<leader>fl', builtin.loclist, { desc = '[f]ind [l]oclist' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[f]ind [r]egisters' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffers' })
vim.keymap.set('n', '<leader>fcf', builtin.current_buffer_fuzzy_find, { desc = '[f]ind words [c]urrent buffer [f]uzzy' })
-- vim.keymap.set('n', '<leader>td', builtin.lsp_document_symbols, { desc = '[t]elescope lsp [d]ocument symbols' })
-- vim.keymap.set('n', '<leader>to', builtin.lsp_dynamic_workspace_symbols, { desc = '[t]elescope lsp dynamic w[o]rkspace symbols' })

telescope.setup {
  defaults = {
    path_display = {
      'truncate',
    },
    layout_strategy = 'vertical',
    layout_config = layout_config,
    mappings = {
      i = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-l>'] = actions.send_to_loclist,
        -- ['<esc>'] = actions.close,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,
      },
      n = {
        q = actions.close,
      },
    },
    preview = {
      treesitter = true,
    },
    history = {
      path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      limit = 1000,
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

telescope.load_extension('fzy_native')
-- telescope.load_extension('smart_history')
