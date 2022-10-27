{ pkgs ? import
    (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ./nixpkgs.json
        )
      )
    )
    { }
}:
let
  poetryEnvironment = pkgs.poetry2nix.mkPoetryEnv {
    projectDir = builtins.path {
      path = ./.;
      name = "Sentinel2_Water_Extraction_poetry";
    };
    overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
      rasterio = super.rasterio.overridePythonAttrs (
        old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            pkgs.gdal
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
