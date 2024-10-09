{ poetry2nix, python }:
poetry2nix.mkPoetryPackages {
  inherit python;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel2_water_extraction_packages";
  };
}
