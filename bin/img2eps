#!/bin/bash

# convert image files to eps files
# requires: imagemagick

im=$(which convert) || exit 1

filename="${1%.*}"
$im -quality 80 $1 EPS3:${filename}.eps

