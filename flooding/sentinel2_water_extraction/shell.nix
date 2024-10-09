let
  pkgs = import ../../nixpkgs.nix;
  python = import ../../python.nix { inherit pkgs; };
  poetry2nix = import ../../poetry2nix.nix { inherit pkgs; };
  poetryPackages = import ./poetryPackages.nix { inherit poetry2nix python; };
in
pkgs.mkShell { packages = [ pkgs.cacert ] ++ poetryPackages.poetryPackages; }
