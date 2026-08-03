# taildrop-install

Binary install for the **Taildrop** desktop app (Tailscale file sharing).
The application source lives in a private repository — this repo contains
only the built binary and its Nix wrapper.

## Install (NixOS, x86_64-linux)

```sh
nix profile install github:Rastavich/taildrop-install
```

then run `tailscale-drop` (it appears in the tray; close-to-tray and the
Ctrl+Shift+T shortcut work as usual).

Requirements: a running `tailscaled` (the app talks to your local Tailscale
daemon — install Tailscale first).

## Update

```sh
nix profile upgrade taildrop-install
```

## Premium

Public drop links are a Premium feature (monthly subscription, billed via
Stripe on the relay). Open Settings → Premium to subscribe or manage your
subscription. Public drops are enforced server-side on the relay — patching
the client cannot bypass them.

## How this repo works

- `tailscale-drop` — the raw binary, replaced on each release by CI in the
  private source repo.
- `flake.nix` — wraps the binary in an FHS environment (WebKitGTK 6.0, GTK4,
  Noto fonts) so it runs on NixOS without system-wide GTK/WebKit.
- The deb/rpm builds for other distros are published on the private repo's
  release page; contact the author for access.
