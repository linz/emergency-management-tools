let
  pkgs =
    import (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ../nixpkgs.json
        )
      )
    ) {
    };
in
  pkgs.mkShell {
    packages = [
      pkgs.nodePackages.mocha
    ];
  }
