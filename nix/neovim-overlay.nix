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
    # (autocompletion) and extensions
    blink-cmp
    blink-copilot
    colorful-menu-nvim
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
    gruvbox-material-nvim
    kanagawa-nvim # sometimes just for mood
    neo-tree-nvim
    oil-nvim
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
    hardtime-nvim
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    nvim-unception
    undotree
    trouble-nvim
    nvim-colorizer-lua
    todo-comments-nvim
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
