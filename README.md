Johnny's Nix managed Neovim configuration

## Installation

### NixOS (with flakes)

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
    aegis
];
```

> [!IMPORTANT]
>
> This flake uses `nixpkgs.wrapNeovimUnstable`, which has an
> unstable signature. If you set `nixpkgs.follows = "nixpkgs";`
> when importing this into your flake.nix, it may break.
> Especially if your nixpkgs input pins a different branch.

### Non-NixOS

With Nix installed (flakes enabled), from the repo root:

```sh
nix profile install .#nvim
```
