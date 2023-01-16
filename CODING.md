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

## CI

### Cache seed

You'll see references to `secrets.CACHE_SEED` in the
[CI configuration](.github/workflows). This is a hack to allow you to
effectively ignore the existing cache entries in case of a cache corruption
(such as caching an invalid package). Simply
[set the `CACHE_SEED` secret](https://github.com/linz/emergency-management-tools/settings)
for all relevant contexts ("Actions" being the main one) to an arbitrary new
value, and the cache key changes correspondingly to something new, resulting in
a fresh cache.
