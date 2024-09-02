{pkgs}:
import (
  builtins.fetchTarball {
    name = "poetry2nix-2024.8.2346599";
    url = "https://github.com/nix-community/poetry2nix/archive/7619e43c2b48c29e24b88a415256f09df96ec276.tar.gz";
    sha256 = "10nf9213h7vkzrqhrgk88r5sd2rq19cvdpnn59f65ifak790sgc0";
  }
) {
  inherit pkgs;
}
