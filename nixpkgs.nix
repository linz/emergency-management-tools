import (
  builtins.fetchTarball {
    name = "nixos-unstable-2024-09-02";
    url = "https://github.com/nixos/nixpkgs/archive/12228ff1752d7b7624a54e9c1af4b222b3c1073b.tar.gz";
    sha256 = "1dmng7f5rv4hgd0b61chqx589ra7jajsrzw21n8gp8makw5khvb2";
  }
) {}
