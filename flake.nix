{
  description = "The Shield of those who wants to code in Neovim with the power of Gods of Olimpus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = {system, ...}: let
        neovim-overlay = import ./nix/neovim-overlay.nix {inherit inputs;};
        pkgs' = import inputs.nixpkgs {
          inherit system;
          overlays = [
            neovim-overlay
            inputs.gen-luarc.overlays.default
          ];
        };
      in {
        packages = {
          default = pkgs'.aegis;
          nvim = pkgs'.aegis;
          nvim-dev = pkgs'.nvim-dev;
        };

        devShells.default = pkgs'.mkShell {
          name = "nvim-devShell";
          buildInputs = with pkgs'; [
            nvim-dev
            alejandra
            lua-language-server
            luajitPackages.luacheck
            nixd
            stylua
          ];
          shellHook = ''
            ln -fs ${pkgs'.nvim-luarc-json} .luarc.json
            ln -Tfns $PWD/nvim ~/.config/nvim-dev
          '';
        };

        formatter = pkgs'.alejandra;
      };

      flake = {
        overlays.default = import ./nix/neovim-overlay.nix {inherit inputs;};
      };
    };
}
