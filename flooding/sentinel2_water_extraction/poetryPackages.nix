{pkgs}:
pkgs.poetry2nix.mkPoetryPackages {
  python = pkgs.python3;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel2_water_extraction_packages";
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
    matplotlib = super.matplotlib.overridePythonAttrs (
      # https://github.com/nix-community/poetry2nix/pull/988
      old: {
        buildInputs =
          (old.buildInputs or [])
          ++ [
            self.pybind11
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
    gdal = super.gdal.overridePythonAttrs (
      # In poetry2nix > 1.39.1
      old: {
        nativeBuildInputs =
          (old.nativeBuildInputs or [])
          ++ [
            pkgs.gdal
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
    shapely = super.shapely.overridePythonAttrs (
      # https://github.com/nix-community/poetry2nix/pull/879
      old: {
        nativeBuildInputs =
          (old.nativeBuildInputs or [])
          ++ [
            pkgs.geos
          ];
      }
    );
  });
}
