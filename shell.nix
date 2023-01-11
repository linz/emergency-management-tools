let
  pkgs = import
    (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ./nixpkgs.json
        )
      )
    )
    { };
in
  pkgs.mkShell {
    packages = [
      pkgs.cacert
      pkgs.gitFull
      pkgs.gitlint
      pkgs.pre-commit
      pkgs.shfmt
    ];
  }
