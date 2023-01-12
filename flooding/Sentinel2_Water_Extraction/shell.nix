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
  poetryEnvironment = import ./poetryEnv.nix {inherit pkgs;};
in
  poetryEnvironment.env
