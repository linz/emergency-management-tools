# Development documentation

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

## Setup

You'll need to install [Nix](https://nixos.org/download.html) and optionally
[Lorri](https://github.com/nix-community/lorri).

For plain Nix there's no other setup. For Lorri, just `cd` into this directory
and run `direnv allow` to enable automatic compilation.

## Nix

To enter the environment without Lorri, run `nix-shell`. With Lorri, you just
need to `cd` into this directory, and it will build in the background. To force
your shell to wait for the build to finish, run `lorri watch --once`.

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
