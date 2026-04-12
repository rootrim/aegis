if vim.g.did_load_treesitter_plugin then
	return
end
vim.g.did_load_treesitter_plugin = true

local textobjects_select = require('nvim-treesitter-textobjects.select')
local textobjects_swap = require('nvim-treesitter-textobjects.swap')
local textobjects_move = require('nvim-treesitter-textobjects.move')
local bind = require('user.bind').bind

-- select
bind({ 'x', 'o' }, 'af', function()
	textobjects_select.select_textobject('@function.outer', 'textobjects')
end, 'Select Outer Function')
bind({ 'x', 'o' }, 'if', function()
	textobjects_select.select_textobject('@function.inner', 'textobjects')
end, 'Select Inner Function')
bind({ 'x', 'o' }, 'ac', function()
	textobjects_select.select_textobject('@class.outer', 'textobjects')
end, 'Select Outer Class')
bind({ 'x', 'o' }, 'ic', function()
	textobjects_select.select_textobject('@class.inner', 'textobjects')
end, 'Select Inner Class')
bind({ 'x', 'o' }, 'as', function()
	textobjects_select.select_textobject('@local.scope', 'locals')
end, 'Select Local Scope')

-- swap
bind('n', '<leader>a', function()
	textobjects_swap.swap_next('@parameter.inner')
end, 'Swap Next Textobject')
bind('n', '<leader>A', function()
	textobjects_swap.swap_previous('@parameter.outer')
end, 'Swap Previous Textobject')

-- move
bind({ 'n', 'x', 'o' }, ']m', function()
	textobjects_move.goto_next_start('@function.outer', 'textobjects')
end, '[m] next function (start)')
bind({ 'n', 'x', 'o' }, ']M', function()
	textobjects_move.goto_next_end('@function.outer', 'textobjects')
end, '[M] next function (end)')
bind({ 'n', 'x', 'o' }, ']p', function()
	textobjects_move.goto_next_start('@parameter.outer', 'textobjects')
end, '[p] next parameter (start)')
bind({ 'n', 'x', 'o' }, ']P', function()
	textobjects_move.goto_next_end('@parameter.outer', 'textobjects')
end, '[P] next parameter (end)')
bind({ 'n', 'x', 'o' }, '[m', function()
	textobjects_move.goto_previous_start('@function.outer', 'textobjects')
end, '[m] previous function (start)')
bind({ 'n', 'x', 'o' }, '[M', function()
	textobjects_move.goto_previous_end('@function.outer', 'textobjects')
end, '[M] previous function (end)')
bind({ 'n', 'x', 'o' }, '[p', function()
	textobjects_move.goto_previous_start('@parameter.outer', 'textobjects')
end, 'previous [p]arameter (start)')
bind({ 'n', 'x', 'o' }, '[P', function()
	textobjects_move.goto_previous_end('@parameter.outer', 'textobjects')
end, 'previous [P]arameter (end)')

require('treesitter-context').setup {
	max_lines = 0,
	multiwindow = true,
}

require('ts_context_commentstring').setup()

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
