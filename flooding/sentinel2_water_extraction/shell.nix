let
  pkgs =
    import
    (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ../../nixpkgs.json
        )
      )
    )
    {};
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
