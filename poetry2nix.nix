{pkgs}:
import (
  builtins.fetchTarball {
    name = "poetry2nix-2024.6.557458";
    url = "https://github.com/nix-community/poetry2nix/archive/81662ae1ad31491eae3bb1d976fb74c71853bc63.tar.gz";
    sha256 = "1zvlhzlc7mxr74qii3mkyn4iyd5rdivrm40yf7r7jvj9ry5gnbx9";
  }
) {
  inherit pkgs;
}
