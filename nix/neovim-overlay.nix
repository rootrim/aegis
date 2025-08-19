{ inputs }:
final: prev:
with final.pkgs.lib;
let
  pkgs = final;

  # mkNvimPlugin = src: pname:
  #   pkgs.vimUtils.buildVimPlugin {
  #     inherit pname src;
  #     version = src.lastModifiedDate;
  #   };

  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
  };

  all-plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    luasnip
    friendly-snippets
    # nvim-cmp (autocompletion) and extensions
    nvim-cmp
    cmp_luasnip
    lspkind-nvim
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-cmdline
    cmp-cmdline-history
    copilot-cmp
    # ^ nvim-cmp extensions
    # lsp extensions
    nvim-lspconfig
    # ^ lsp extensions
    # formatting
    conform-nvim
    # ^ formatting
    # git integration plugins
    gitsigns-nvim
    # ^ git integration plugins
    # telescope and extensions
    telescope-nvim
    telescope-fzy-native-nvim
    # ^ telescope and extensions
    # UI
    lualine-nvim
    nvim-treesitter-context
    kanagawa-nvim
    neo-tree-nvim
    bufferline-nvim
    # ^ UI
    # language support
    rustaceanvim
    render-markdown-nvim
    copilot-lua
    lazydev-nvim
    # ^ language support
    # navigation/editing enhancement plugins
    # vim-unimpaired 
    eyeliner-nvim
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-parinfer
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    nvim-unception
    undotree
    trouble-nvim
    # ^ Useful utilities
    # libraries that other plugins depend on
    mini-nvim
    snacks-nvim
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    # ^ libraries that other plugins depend on
    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
    which-key-nvim
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil
    stylua
    nixfmt-classic
    nodejs-slim_24
  ];
in {
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  nvim-luarc-json = final.mk-luarc-json { plugins = all-plugins; };
}
