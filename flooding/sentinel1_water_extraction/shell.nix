let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
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
