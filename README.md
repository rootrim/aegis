<br />
<div align="center">
  <p>
    <strong>
      A dead simple <a href="https://neovim.io/">Neovim</a> config repository</br>
      based on <a href="https://github.com/nix-community/kickstart-nix.nvim">kickstart-nix.nvim</a> 
    </strong>
  </p>

[![Neovim][neovim-shield]][neovim-url]
[![Nix][nix-shield]][nix-url]
[![Lua][lua-shield]][lua-url]

[![GPL2 License][license-shield]][license-url]
[![Issues][issues-shield]][issues-url]
</div>
<!-- markdownlint-restore -->

## :star2: Features

- Basic ***use everywhere anytime*** plugins
- Access from any *nix installed* computer with `nix run github:rootrim/aegis`
- Create multiple derivations with different sets of plugins,
  and simple regex filters to exclude config files.
- Uses Nix to generate a `.luarc.json` in the devShell's `shellHook`.
  This sets up lua-language-server to recognize all plugins
  and the Neovim API.

## :zap: Installation

### :snowflake: NixOS (with flakes)

1. Add your flake to you NixOS flake inputs.
1. Add the overlay provided by this flake.

```nix
nixpkgs.overlays = [
    inputs.aegis.overlays.default
];
```

You can then add the overlay's output(s) to the `systemPackages`:

```nix
environment.systemPackages = with pkgs; [
    nvim-pkg
];
```

> [!IMPORTANT]
>
> This flake uses `nixpkgs.wrapNeovimUnstable`, which has an
> unstable signature. If you set `nixpkgs.follows = "nixpkgs";`
> when importing this into your flake.nix, it may break.
> Especially if your nixpkgs input pins a different branch.

### :penguin: Non-NixOS

With Nix installed (flakes enabled), from the repo root:

```console
nix profile install .#nvim
```

## :robot: Design

Directory structure:

```sh
── flake.nix
── nvim # Neovim configs (lua), equivalent to ~/.config/nvim
── nix # Nix configs
```

<!-- MARKDOWN LINKS & IMAGES -->
[neovim-shield]: https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white
[neovim-url]: https://neovim.io/
[nix-shield]: https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white
[nix-url]: https://nixos.org/
[lua-shield]: https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white
[lua-url]: https://www.lua.org/
[license-shield]: https://img.shields.io/github/license/nix-community/kickstart-nix.nvim.svg?style=for-the-badge
[license-url]: https://github.com/rootrim/aegis/blob/main/LICENSE
[issues-shield]: https://img.shields.io/github/issues/nix-community/kickstart-nix.nvim.svg?style=for-the-badge
[issues-url]: https://github.com/rootrim/aegis/issues
[license-shield]: https://img.shields.io/github/license/nix-community/kickstart-nix.nvim.svg?style=for-the-badge
[license-url]: https://github.com/nix-community/kickstart-nix.nvim/blob/master/LICENSE
