# Sentinel-2 Water Extraction

The sentinel2_water_extraction Jupyter Notebook was developed to extract water
from Sentinel-2 optical imagery.

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
   -  3.8
   -  3.9
   -  3.10
   -  3.11

## Get the Jupyter Notebook

Either

-  [download a zip file](https://github.com/linz/emergency-management-tools/archive/refs/heads/master.zip)
   or
-  clone this repository with
   `git clone git@github.com:linz/emergency-management-tools.git`.

## Install Python dependencies

Open the terminal and navigate to the notebook directory

`cd <path where downloaded to>/emergency-management/flooding/sentinel2_water_extraction`

The following commands will install the dependencies for just this project:

```shell
poetry install --only=main --no-root
```

## Start the Jupyter Notebook

Start the notebook with
`poetry run jupyter notebook sentinel2_water_extraction.ipynb`. This will open
the notebook in a browser.

## Extract water from Sentinel-2 imagery

[Execute the steps](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/execute.html#executing-a-notebook)
in the Notebook to extract water polygons.

## Troubleshooting

### SSL cert errors

If encountering an SSL cert error, try exporting a reference to
`ca-certificates.crt`

e.g `export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
