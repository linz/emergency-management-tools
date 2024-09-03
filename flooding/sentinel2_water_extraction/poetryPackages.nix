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
  overrides = poetry2nix.overrides.withDefaults (_final: prev: {
    argon2-cffi-bindings = prev.argon2-cffi-bindings.override {
      preferWheel = true;
    };
  });
}
