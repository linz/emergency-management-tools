# Sentinel-2 Water Extraction

The sentinel2_water_extraction Jupyter Notebook was developed to extract water
from Sentinel-2 optical imagery.

Below are the instructions to get the notebook up and running.

## Get the Jupyter Notebook

If you just want the _latest contents:_

1. [Download the repository](https://github.com/linz/emergency-management-tools/archive/refs/heads/master.zip)
1. Unpack the zip file using a file explorer or
   `unzip emergency-management-tools-master.zip` on the command line

If you would like the _full repository history,_ for example to do some
development yourself, clone this repository with
`git clone git@github.com:linz/emergency-management-tools.git`

## Setup

### Nix

If you are running Linux, macOS, or a Windows machine with WSL, this is the
easiest setup. The only dependency is the
[Nix package manager](https://nixos.org/download.html). Please select your
platform and follow the instructions.

Once Nix is installed,
`cd [emergency-management-tools path]/flooding/sentinel2_water_extraction` and
run `nix-shell` to install all the dependencies. This could take a long time the
first time it runs.

### Non-nix

If you can't use Nix, you will need the following. For each prerequisite, the
[automatically tested](.github/workflows/test.yml) version is included.

-  One of these operating systems:
   -  Linux (tested on Ubuntu 22.04, Jammy Jellyfish and 24.04, Noble Numbat)
   -  macOS (tested on version 12, Monterey)
   -  Windows (tested on Windows Server 2022)
-  [Python](https://www.python.org/downloads/) (tested with 3.9 and 3.12)
-  [Poetry](https://python-poetry.org/docs/#installation) (tested with 1.8.3)
-  [GDAL](https://gdal.org/download.html) (tested with 3.9.2)

Once you have all of the above,
`cd [emergency-management-tools path]/flooding/sentinel2_water_extraction` and
install Python packages for this project with
`poetry install --only=main --no-root`. Finally run `poetry shell` to make the
Python packages available.

## Start the Jupyter Notebook

Start the notebook with `jupyter notebook sentinel2_water_extraction.ipynb`.
This will open the notebook in a browser.

## Extract water from Sentinel-2 imagery

Follow the instructions in the notebook to
[execute](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/execute.html#executing-a-notebook)
it and extract water polygons.

## Troubleshooting

### SSL cert errors

If encountering an SSL cert error, try exporting a reference to
`ca-certificates.crt`

e.g `export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
