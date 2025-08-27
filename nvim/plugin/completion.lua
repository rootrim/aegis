if vim.g.did_load_completion_plugin then
  return
end
vim.g.did_load_completion_plugin = true

local colorful_menu = require('colorful-menu')
local blink = require('blink.cmp')
local ls = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

blink.setup {
  completion = {
    ghost_text = { enabled = true },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },

    keyword = {
      range = 'full',
    },

    menu = {
      direction_priority = function()
        local ctx = blink.get_context()
        local item = blink.get_selected_item()
        if ctx == nil or item == nil then
          return { 's', 'n' }
        end

        local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
        local is_multi_line = item_text:find('\n') ~= nil

        if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
          vim.g.blink_cmp_upwards_ctx_id = ctx.id
          return { 'n', 's' }
        end
        return { 's', 'n' }
      end,
      draw = {
        columns = { { 'label', gap = 1 }, { 'kind_icon' }, { 'kind' } },
        components = {
          label = {
            text = function(ctx)
              return colorful_menu.blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return colorful_menu.blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },
  signature = {
    enabled = true,
  },
  sources = {
    default = { 'lazydev', 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
  snippets = {
    preset = 'luasnip',
  },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = true } },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}

vim.keymap.set({ 'i' }, '<C-K>', function()
  ls.expand {}
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-E>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
