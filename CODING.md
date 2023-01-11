# Development documentation

## Prerequisites

[Nix](https://nixos.org/download.html), optionally [lorri](https://github.com/nix-community/lorri).

To enter the development environment, simply run `nix-shell`.

## pre-commit

### Install hooks

```shell
pre-commit install --hook-type=commit-msg --hook-type=pre-commit --overwrite
```

### Update configuration to latest versions

```shell
pre-commit autoupdate --freeze
```