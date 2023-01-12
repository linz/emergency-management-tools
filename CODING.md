# Development documentation

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

## Prerequisites

[Nix](https://nixos.org/download.html), optionally
[lorri](https://github.com/nix-community/lorri).

To enter the development environment, simply run `nix-shell`.

## Nix

### Update nixpkgs version

Run `./bump-nixpkgs.bash` and follow the instructions. Generally we should be
using the latest stable ["nixos-YY.MM" channel](https://status.nixos.org/).

## pre-commit

### Install hooks

```shell
pre-commit install --hook-type=commit-msg --hook-type=pre-commit --overwrite
```

### Update configuration to latest versions

```shell
pre-commit autoupdate --freeze
```
