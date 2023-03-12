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

Run `niv update`. Generally we should be using the latest stable
["nixos-YY.MM" channel](https://status.nixos.org/).

## pre-commit

### Run hooks manually

See [test workflow](.github/workflows/test.yml)

### Install hooks to run automatically

```shell
pre-commit install --hook-type=commit-msg --hook-type=pre-commit --overwrite
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

## Website

Use
`nix-shell --pure --run 'github-pages build && jekyll serve --no-watch --skip-initial-build'`
to serve up a local copy of the website. This ensures that you see exactly what
the `github-pages build` produces, as opposed to letting `jekyll serve` rebuild
the site.

Make sure to [`exclude`](_config.yml) any new files which are not explicitly
part of the website. The simplest way to verify this is to run
`github-pages build` and look at the contents of [the `_site` directory](_site).
