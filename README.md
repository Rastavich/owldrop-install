# owldrop-install

Binary install for the **Owldrop** desktop app (Tailscale file sharing).
The application source lives in the public repo
[github.com/Rastavich/owldrop](https://github.com/Rastavich/owldrop) — this
repo contains only the built binary and its Nix wrapper.

## Install (NixOS, x86_64-linux)

```sh
nix profile install github:Rastavich/owldrop-install
```

then run `owldrop-drop` (it appears in the tray; close-to-tray and the
Ctrl+Shift+T shortcut work as usual).

Requirements: a running `tailscaled` (the app talks to your local Tailscale
daemon — install Tailscale first).

## Update

```sh
nix profile upgrade owldrop-install
```

## How this repo works

- `owldrop-drop` — the raw binary, replaced on each release by CI in the
  source repo.
- `flake.nix` — wraps the binary in an FHS environment (WebKitGTK 6.0, GTK4,
  Noto fonts) so it runs on NixOS without system-wide GTK/WebKit.
- The deb/rpm builds for other distros are published on the source repo's
  [release page](https://github.com/Rastavich/owldrop/releases).
