{
  pkgs,
  python,
}:
pkgs.poetry2nix.mkPoetryPackages {
  inherit python;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel2_water_extraction_packages";
  };
  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
    annotated-types = super.annotated-types.overridePythonAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.hatchling];
    });
    pydantic = super.pydantic.overridePythonAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.hatchling self.hatch-fancy-pypi-readme];
    });
    pydantic-core = super.pydantic-core.override {
      preferWheel = true;
    };
  });
}
