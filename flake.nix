{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        typst-font-paths = builtins.concatStringsSep ":" (map (font: "${font}/share/fonts") [pkgs.ipaexfont]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            typstyle
            ipaexfont
          ];

          shellHook = ''
            export TYPST_FONT_PATHS="${typst-font-paths}"
          '';

          shellWrapper = pkgs.writeShellScript "dev-shell" ''
            exec ${pkgs.zsh}/bin/zsh \"$@\"
          '';
        };
      }
    );
}
