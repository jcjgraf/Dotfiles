#!/bin/bash

# Corlorize non-xresources application by replacing specified tags by colors from .Xresources file
## Usage: colorizer.sh <rawFile> <outputFile>


# Copy file to temp dir
outfile="$2"
cp "$1" "$outfile"

# Load colors and replace
for i in {0..15}
do
    color="$( xrdb -query | grep color${i}: | awk '{print $NF}' )"
    eval "sed -i 's/%color${i}%/${color}/g' $outfile";
done

foreground="$( xrdb -query | grep foreground: | awk '{print $NF}' )"
background="$( xrdb -query | grep background: | awk '{print $NF}' )"
sed -i "s/%colorfg%/${foreground}/g" $outfile
sed -i "s/%colorbg%/${background}/g" $outfile
