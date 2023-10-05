let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  python = import ./python.nix {
    inherit pkgs;
  };
  sentinel1WaterExtractionPoetryPackages = import ./flooding/sentinel1_water_extraction/poetryPackages.nix {
    inherit pkgs python;
  };
  sentinel2WaterExtractionPoetryPackages = import ./flooding/sentinel2_water_extraction/poetryPackages.nix {
    inherit pkgs python;
  };
  pythonWithAllPackages =
    (
      python.withPackages (
        ps:
          [
            ps.mypy
            ps.pip
            ps.pylint
            ps.types-python-dateutil
          ]
          ++ sentinel1WaterExtractionPoetryPackages.poetryPackages
          ++ sentinel2WaterExtractionPoetryPackages.poetryPackages
      )
    )
    .override (
      _args: {
        ignoreCollisions = true;
      }
    );
in
  pkgs.mkShell {
    packages = [
      pythonWithAllPackages
      pkgs.alejandra
      pkgs.black
      pkgs.cacert
      pkgs.check-jsonschema
      pkgs.deadnix
      pkgs.gitFull
      pkgs.gitlint
      pkgs.nbqa
      pkgs.niv
      pkgs.nodePackages.prettier
      pkgs.pre-commit
      pkgs.python3Packages.pydocstyle
      pkgs.rubyPackages.github-pages
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.statix
    ];

    shellHook = ''
      ln --force --no-target-directory --symbolic "${python}/bin/python" python
    '';
  }
