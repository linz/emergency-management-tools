let
  pkgs = import ./nixpkgs.nix;
  poetry2nix = import ./poetry2nix.nix {
    inherit pkgs;
  };
  python = import ./python.nix {
    inherit pkgs;
  };
  sentinel1WaterExtractionPoetryPackages = import ./flooding/sentinel1_water_extraction/poetryPackages.nix {
    inherit poetry2nix python;
  };
  sentinel2WaterExtractionPoetryPackages = import ./flooding/sentinel2_water_extraction/poetryPackages.nix {
    inherit poetry2nix python;
  };
  pythonWithAllPackages =
    (
      (
        python.withPackages (
          ps: [
            ps.mypy
            ps.pip
            ps.pylint
            ps.types-python-dateutil
          ]
        )
      )
      .withPackages (_ps: sentinel1WaterExtractionPoetryPackages.poetryPackages)
    )
    .withPackages (_ps: sentinel2WaterExtractionPoetryPackages.poetryPackages);
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
