{pkgs}:
pkgs.poetry2nix.mkPoetryPackages {
  python = pkgs.python3;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel2_water_extraction_packages";
  };
}
