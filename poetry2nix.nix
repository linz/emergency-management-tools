{pkgs}:
import (
  builtins.fetchTarball {
    url = "https://github.com/nix-community/poetry2nix/archive/403d923ea8e2e6cedce3a0f04a9394c4244cb806.tar.gz";
    sha256 = "09bb57aijypgicl7yzgsh7mchp4rsi9a64g6yvbwsbbbjgd1ig07";
  }
) {
  inherit pkgs;
}
