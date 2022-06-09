{ pkgs ? import
    (
      fetchTarball {
        name = "22.05";
        url = "https://github.com/NixOS/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz";
        sha256 = "0d643wp3l77hv2pmg2fi7vyxn4rwy0iyr8djcw1h5x72315ck9ik";
      })
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
