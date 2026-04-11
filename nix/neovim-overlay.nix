{inputs}: final: prev:
with final.pkgs.lib; let
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
    # (autocompletion) and extensions
    blink-cmp
    colorful-menu-nvim
    friendly-snippets
    # ^ cmp extensions
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
    gruvbox-material
    kanso-nvim
    oil-nvim
    bufferline-nvim
    # ^ UI
    # language support
    rustaceanvim
    render-markdown-nvim
    lazydev-nvim
    # ^ language support
    # navigation/editing enhancement plugins
    eyeliner-nvim
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-parinfer
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    nvim-unception
    undotree
    trouble-nvim
    nvim-colorizer-lua
    todo-comments-nvim
    tabout-nvim
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
    # language servers, formatters, etc.
    alejandra
    bash-language-server
    clang-tools
    clippy
    fish-lsp
    lua-language-server
    luajitPackages.luacheck
    nil
    nixd
    rust-analyzer
    rustfmt
    shfmt
    stylua
    zig
    zls
  ];
in {
  aegis = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  nvim-dev = mkNeovim {
    plugins = all-plugins;
    appName = "nvim-dev";
    wrapRc = false;
  };

  nvim-luarc-json = final.mk-luarc-json {plugins = all-plugins;};
}
