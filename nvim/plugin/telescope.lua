if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local bind = require('user.bind').bind
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

bind('n', '<leader>fp', builtin.oldfiles, '[F]ind [P]revious files')
bind('n', '<leader>fg', builtin.live_grep, '[F]ind words (live [G]rep)')
bind('n', '<leader>ff', project_files, '[F]ind [F]iles')
bind('n', '<leader>fq', builtin.quickfix, '[F]ind [Q]uickfix list')
bind('n', '<leader>fh', builtin.command_history, '[F]ind command [H]istory')
bind('n', '<leader>fl', builtin.loclist, '[F]ind [L]oclist')
bind('n', '<leader>fr', builtin.registers, '[F]ind [R]egisters')
bind('n', '<leader>fb', builtin.buffers, '[F]ind [B]uffers')
bind('n', '<leader>ft', builtin.marks, '[F]ind [M]arks')
bind('n', '<leader>fz', builtin.current_buffer_fuzzy_find, '[F]ind words current buffer fu[Z]zy')

telescope.setup {
  defaults = {
    path_display = {
      'truncate',
    },
    layout_strategy = 'horizontal',
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
