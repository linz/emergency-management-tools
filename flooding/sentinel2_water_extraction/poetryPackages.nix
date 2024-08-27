{
  poetry2nix,
  python,
}:
poetry2nix.mkPoetryPackages {
  inherit python;
  projectDir = builtins.path {
    path = ./.;
    name = "sentinel2_water_extraction_packages";
  };
  overrides = poetry2nix.overrides.withDefaults (self: super: {
    color-operations = super.color-operations.overridePythonAttrs (old: {
      # https://github.com/nix-community/poetry2nix/pull/1658
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.cython_0];
    });
    jupyter-server = super.jupyter-server.overridePythonAttrs (old: {
      # Already in poetry2nix but needed here because we're mixing old and new versions of jupyter-server
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [self.jupyter-packaging];
    });
  });
}
