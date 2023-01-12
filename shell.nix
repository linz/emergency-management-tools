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
  sentinel2WaterExtractionPoetryPackages = import ./flooding/Sentinel2_Water_Extraction/poetryPackages.nix {
    inherit pkgs;
  };
in
  pkgs.mkShell {
    packages = [
      (sentinel2WaterExtractionPoetryPackages.python.withPackages (ps:
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
          ps.types-python-dateutil
        ]
        ++ sentinel2WaterExtractionPoetryPackages.poetryPackages))
      pkgs.alejandra
      pkgs.cacert
      pkgs.gitFull
      pkgs.gitlint
      pkgs.nodePackages.prettier
      pkgs.pre-commit
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.statix
    ];
  }
