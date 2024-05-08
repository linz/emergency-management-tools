# Sentinel-1 Water Extraction

The sentinel1_water_extraction Jupyter Notebook was developed to extract water
from Sentinel-1 optical imagery.

Below are the instructions to get the notebook up and running.

## Prerequisites

-  Linux, macOS, or Windows
-  Python
-  [Poetry](https://python-poetry.org/docs/#installation)

[Tested](.github/workflows/test.yml) with:

-  OS:
   -  Ubuntu 22.04 (Jammy Jellyfish)
   -  macOS 12 (Monterey)
   -  Windows Server 2022
-  Python:
   -  3.9
   -  3.10
   -  3.11

## Get the Jupyter Notebook

If you just want the _latest contents:_

1. [Download the repository](https://github.com/linz/emergency-management-tools/archive/refs/heads/master.zip)
1. Unpack the zip file using a file explorer or `unzip master.zip` on the
   command line
1. Go to the relevant directory with
   `cd [download path]/emergency-management-tools-master/flooding/sentinel1_water_extraction`

If you would like the _full repository history,_ for example to do some
development yourself:

1. Clone this repository with
   `git clone git@github.com:linz/emergency-management-tools.git`
1. Go to the relevant directory with
   `cd emergency-management-tools/flooding/sentinel1_water_extraction`

## Install dependencies

Install the dependencies for this project with
`poetry install --only=main --no-root`.

## Start the Jupyter Notebook

Start the notebook with
`poetry run jupyter notebook sentinel1_water_extraction.ipynb`. This will open
the notebook in a browser.

## Extract water from Sentinel-1 imagery

Follow the instructions in the notebook to
[execute](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/execute.html#executing-a-notebook)
it and extract water polygons.

## Troubleshooting

### SSL cert errors

If encountering an SSL cert error, try exporting a reference to
`ca-certificates.crt`

e.g `export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
