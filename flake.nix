# owldrop-install — binary-only distribution of the owldrop desktop app.
#
# The Go source lives at github.com/Rastavich/owldrop; this repo ships just
# the built binary (owldrop-drop at the repo root, replaced on each release)
# plus a thin Nix wrapper: an FHS environment providing WebKitGTK 6.0, GTK4,
# and the bundled fonts the binary needs at runtime.
{
  description = "Owldrop desktop app — binary install for NixOS (source: github.com/Rastavich/owldrop)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.default = pkgs.buildFHSEnv {
        name = "owldrop-drop";
        # noto-fonts is deliberate: WebKitGTK/Pango lays DejaVu Sans text at
        # the top of the line box, so the UI's font stack leads with Noto.
        targetPkgs = ps: with ps; [
          gtk4 webkitgtk_6_0 glib-networking gsettings-desktop-schemas dconf
          fontconfig dejavu_fonts noto-fonts
        ];
        runScript = pkgs.writeShellScript "owldrop-drop-run" ''
          export FONTCONFIG_FILE="${pkgs.makeFontsConf { fontDirectories = [ pkgs.dejavu_fonts ]; }}"
          exec ${self}/owldrop-drop "$@"
        '';
      };
    };
}
