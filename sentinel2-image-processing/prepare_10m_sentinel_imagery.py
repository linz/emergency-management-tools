#!/usr/bin/env python3

"""
This is a Python version of a bash script written by Rebecca Clarke https://gist.github.com/rebclarke/b9e55a3558be3ec76248c78379b67366
"""

import os
import glob
import shutil
from osgeo import gdal
import subprocess


# user definated variables
TILE_INDEX = "nz-150k-tile-index.shp"
MIN = "800"
MAX = "3000"
CWD = "C:/Temp/image-processing/test"
SENTINEL_IMAGE_DIR = "R10m"
GDAL_DIR = "C:/Program Files/QGIS 3.34.4/apps/Python39/Scripts"


def make_directories(dir_name):
    """
    Create directors for the various processed images to be saved into.
    If they already exist, they'll be deleted and recreated.
    """
    path = os.path.join(CWD, dir_name)
    if os.path.exists(path):
        shutil.rmtree(path)
    os.mkdir(path)


# make output directories
make_directories("output")
make_directories("output/merged")
make_directories("output/rescaled")
make_directories("output/nearblack")
make_directories("output/reprojected")
make_directories("output/tiled")


path = os.path.join(CWD, SENTINEL_IMAGE_DIR)
rgb_files = glob.glob("R10m/*B0[2-4]_10m.jp2")

blue = rgb_files[0]
green = rgb_files[1]
red = rgb_files[2]

gdal_merge_path = os.path.join(GDAL_DIR, "gdal_merge.py")

merged_output = os.path.join(CWD, "output/merged", "merged.tif")
translate_output = os.path.join(CWD, "output/rescaled", "rescaled.tif")
nearblack_output = os.path.join(CWD, "output/nearblack", "nearblack.tif")
reprojected_output = os.path.join(CWD, "output/reprojected", "reprojected.tif")
tiled_output_dir = os.path.join(CWD, "output/tiled")
vrt_output = os.path.join(CWD, "output", "overall.vrt")

# merge the three R,G,B images together to create a single RGB image
print("Merging image tiles into one RGB image")
subprocess.run(
    [
        "python.exe",
        gdal_merge_path,
        "-separate",
        "-co",
        "PHOTOMETRIC=RGB",
        "-o",
        merged_output,
        red,
        green,
        blue,
    ]
)

# rescale the imagery to 8bit unsigned
print("Rescaling to  8bit unsigned")
subprocess.run(
    [
        "gdal_translate",
        "-ot",
        "Byte",
        "-of",
        "GTiff",
        "-scale",
        MIN,
        MAX,
        "1",
        "255",
        "-b",
        "1",
        "-b",
        "2",
        "-b",
        "3",
        "-co",
        "compress=lzw",
        merged_output,
        translate_output,
    ]
)

# run nearblack
print("Running nearblack and setting alpha channel")
subprocess.run(
    [
        "nearblack",
        "-of",
        "GTiff",
        "-setalpha",
        "-o",
        nearblack_output,
        translate_output,
    ]
)

# reproject to NZTM 2000
print("Reprojecting to NZTM 2000")
subprocess.run(
    [
        "gdalwarp",
        "-t_srs",
        "EPSG:2193",
        "-r",
        "bilinear",
        "-tr",
        "10",
        "-10",
        "-co",
        "compress=lzw",
        nearblack_output,
        reprojected_output,
    ]
)

# mosaic into a single image
print("Building VRT")
subprocess.run(["gdalbuildvrt", vrt_output, reprojected_output])

print("Tiling to Topo 50")
ogr_info = subprocess.Popen(
    ["ogrinfo", "-ro", "-al", TILE_INDEX], stdout=subprocess.PIPE
)

# tile into Topo50 sheet extents
ogr_output = ogr_info.communicate()[0].decode("utf-8")
for line in ogr_output.splitlines():
    if "sheet_code" in line:
        sheet_code = line[len(line) - 4 : len(line) - 0]
        subprocess.run(
            [
                "gdalwarp",
                vrt_output,
                f"{tiled_output_dir}/{sheet_code}.tif",
                "-cutline",
                TILE_INDEX,
                "-cwhere",
                f"sheet_code = '{sheet_code}'",
                "-tr",
                "10",
                "-10",
                "-co",
                "compress=lzw",
                "-t_srs",
                "EPSG:2193",
                "-crop_to_cutline",
            ]
        )
