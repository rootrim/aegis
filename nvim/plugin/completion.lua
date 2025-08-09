if vim.g.did_load_completion_plugin then
  return
end
vim.g.did_load_completion_plugin = true

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

vim.opt.completeopt = "menu,menuone,noinsert"

cmp.setup({
	mapping = cmp.mapping.preset.insert({ -- Preset: ^n, ^p, ^y, ^e, you know the drill..
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
    { name = "buffer" },
	}),
  formatting = {
    source_names = {
      nvim_lsp = "(LSP)",
      emoji = "(Emoji)",
      path = "(Path)",
      calc = "(Calc)",
      cmp_tabnine = "(Tabnine)",
      vsnip = "(Snippet)",
      luasnip = "(Snippet)",
      buffer = "(Buffer)",
      tmux = "(TMUX)",
      copilot = "(Copilot)",
      codeium = "(Codeium)",
      treesitter = "(TreeSitter)",
    },
    duplicates_default = 0,
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = {
        menu = 50,
        abbr = 50,
      },
      ellipsis_char = '...',
      show_labelDetails = true,

      before = function (entry, vim_item)
        --- ...
        -- vim_item.kind = "H"
        return vim_item
      end
    })
  }

})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline_history' },
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})


local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function enable_and_config(server, config)
  vim.lsp.enable(server)
  config["capabilities"] = capabilities
  vim.lsp.config(server, config)
end

local servers = {
  "nil_ls",
  "lua_ls"
}

for _, server in ipairs(servers) do
  enable_and_config(server, {})
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)
