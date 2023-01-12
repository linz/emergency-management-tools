let
  pkgs =
    import
    (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ./nixpkgs.json
        )
      )
    )
    {};
  sentinel2WaterExtractionEnv = import ./flooding/Sentinel2_Water_Extraction/poetryEnv.nix {inherit pkgs;};
in
  pkgs.mkShell {
    buildInputs = [
      sentinel2WaterExtractionEnv
    ];
    packages = [
      pkgs.alejandra
      pkgs.cacert
      pkgs.gitFull
      pkgs.gitlint
      pkgs.nodePackages.prettier
      pkgs.pre-commit
      pkgs.shellcheck
      pkgs.shfmt
    ];
  }
