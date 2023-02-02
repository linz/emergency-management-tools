let
  pkgs =
    import
    (
      fetchTarball (
        builtins.fromJSON (
          builtins.readFile ./nixpkgs.json
        )
      )
    )
    {};
  sentinel2WaterExtractionPoetryPackages = import ./flooding/sentinel2_water_extraction/poetryPackages.nix {
    inherit pkgs;
  };
  python = sentinel2WaterExtractionPoetryPackages.python.withPackages (
    ps:
      [
        (
          ps.buildPythonPackage rec {
            pname = "nbqa";
            version = "1.6.1";
            src = ps.fetchPypi {
              inherit pname version;
              hash = "sha256-NtvXFV7XMZ7S+rPxmnAhWrO1VUpRY5D9v/jIhMPAlYw=";
            };
            buildInputs = [
              ps.ipython
              ps.tomli
              ps.tokenize-rt
            ];
            propagatedBuildInputs = [
              ps.tokenize-rt
            ];
          }
        )
        ps.mypy
        ps.pylint
        ps.types-python-dateutil
      ]
      ++ sentinel2WaterExtractionPoetryPackages.poetryPackages
  );
in
  pkgs.mkShell {
    packages = [
      python
      pkgs.alejandra
      pkgs.black
      pkgs.cacert
      pkgs.check-jsonschema
      pkgs.gitFull
      pkgs.gitlint
      pkgs.nodePackages.prettier
      pkgs.pre-commit
      pkgs.python3Packages.pydocstyle
      pkgs.rubyPackages.github-pages
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.statix
    ];

    shellHook = ''
      ln --force --no-target-directory --symbolic "${python}" .venv
    '';
  }
