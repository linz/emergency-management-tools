let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  poetryPackages = import ./poetryPackages.nix {
    inherit pkgs;
  };
in
  pkgs.mkShell {
    packages =
      [
        pkgs.cacert
      ]
      ++ poetryPackages.poetryPackages;
  }
