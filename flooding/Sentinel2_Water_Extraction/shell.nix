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
  poetryEnvironment = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python39;
    projectDir = builtins.path {
      path = ./.;
      name = "Sentinel2_Water_Extraction_poetry";
    };
    overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
      color-operations = super.color-operations.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              self.setuptools
            ];
        }
      );
      morecantile = super.morecantile.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              self.flit-core
            ];
        }
      );
      rasterio = super.rasterio.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              pkgs.gdal
            ];
        }
      );
      rio-tiler = super.rio-tiler.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              self.hatchling
            ];
        }
      );
      sat-search = super.sat-search.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              self.setuptools
            ];
        }
      );
      sat-stac = super.sat-stac.overridePythonAttrs (
        # In poetry2nix > 1.39.1
        old: {
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              self.setuptools
            ];
        }
      );
    });
  };
in
  poetryEnvironment.env.overrideAttrs (
    oldAttrs: {
      buildInputs = [
        pkgs.cacert
      ];
    }
  )
