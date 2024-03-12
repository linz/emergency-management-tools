let
  pkgs = import ../nixpkgs.nix;
in
  pkgs.mkShell {
    packages = [
      pkgs.nodePackages.mocha
    ];
  }
