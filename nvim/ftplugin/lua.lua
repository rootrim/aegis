require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

local lsp = require('user.lsp')

lsp.enable_and_config('lua_ls', {})
