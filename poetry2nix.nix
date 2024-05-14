{pkgs}:
import (
  builtins.fetchTarball {
    url = "https://github.com/nix-community/poetry2nix/archive/291a863e866972f356967d0a270b259f46bf987f.tar.gz";
    sha256 = "1mzsvkbxh5c1j82gsghfa3gc0amnsajygbw7n6wxn9mg48j5y45x";
  }
) {
  inherit pkgs;
}
