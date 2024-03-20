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
    jupyterlab = super.jupyterlab.overridePythonAttrs (old: {
      # TODO: Remove when using poetry2nix > 1.41
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.hatchling self.hatch-jupyter-builder];
    });
    overrides = super.overrides.overridePythonAttrs (old: {
      # TODO: Remove when using poetry2nix > 1.41
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.setuptools];
    });
  });
}
