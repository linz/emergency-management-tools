{pkgs}: let
  poetry2nix = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/poetry2nix/archive/2024.10.1046757.tar.gz";
    sha256 = "10a23a7nja7s4r146dxy7s0a7siww4pampxa8hq81bflkhrjlh86";
  }) {inherit pkgs;};
in
  poetry2nix.overrideScope (_finalPoetry2nix: prevPoetry2nix: {
    defaultPoetryOverrides = prevPoetry2nix.defaultPoetryOverrides.extend (final: prev: {
      jupyter-server = prev.jupyter-server.overridePythonAttrs (old: {
        # Already in poetry2nix but needed here because we're mixing old and new versions of jupyter-server
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [final.jupyter-packaging];
      });
      sat-search = prev.sat-search.overridePythonAttrs (old: {
        # https://github.com/sat-utils/sat-search/pull/136
        patches =
          (old.patches or [])
          ++ pkgs.lib.optionals (!(old.src.isWheel or false)) [
            (pkgs.writeText "sat-search-importlib.patch" ''
              --- a/setup.py
              +++ b/setup.py
              @@ -1,9 +1,20 @@
               #!/usr/bin/env python
              +import importlib.util
              +import importlib.machinery
               from setuptools import setup, find_packages
              -from imp import load_source
               from os import path
               import io

              +def load_source(modname, filename):
              +    loader = importlib.machinery.SourceFileLoader(modname, filename)
              +    spec = importlib.util.spec_from_file_location(modname, filename, loader=loader)
              +    module = importlib.util.module_from_spec(spec)
              +    # The module is always executed and not cached in sys.modules.
              +    # Uncomment the following line to cache the module.
              +    # sys.modules[module.__name__] = module
              +    loader.exec_module(module)
              +    return module
              +
               __version__ = load_source('satsearch.version', 'satsearch/version.py').__version__

               here = path.abspath(path.dirname(__file__))
            '')
          ];
      });
    });
  })
