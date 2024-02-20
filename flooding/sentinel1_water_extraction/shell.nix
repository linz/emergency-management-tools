let
  pkgs = import ../../nixpkgs.nix;
  python = import ../../python.nix {
    inherit pkgs;
  };
  poetryPackages = import ./poetryPackages.nix {
    inherit pkgs python;
  };
in
  pkgs.mkShell {
    packages =
      [
        pkgs.cacert
      ]
      ++ poetryPackages.poetryPackages;
  }
