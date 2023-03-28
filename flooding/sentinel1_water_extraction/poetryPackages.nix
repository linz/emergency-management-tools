{
  pkgs,
  python,
}:
pkgs.poetry2nix.mkPoetryPackages {
  inherit python;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel1_water_extraction_packages";
  };
  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
    jupyter-ydoc = super.jupyter-ydoc.overridePythonAttrs (old: {
      # TODO: Remove when using poetry2nix > 1.40.1
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.hatch-nodejs-version];
    });
  });
}
