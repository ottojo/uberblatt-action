#!/bin/bash
REPO_ROOT="$(pwd)"
OUT_DIR="$(pwd)/build"

for directory in */; do
    echo "Building $directory"
    cd $directory
    mkdir -p $OUT_DIR/$directory
    latexmk -pdf -output-directory=$OUT_DIR/$directory
    # Remove every output that isn't a PDF
    find $OUT_DIR/$directory -type f ! -name "*.pdf" -exec rm {} \;
    cd ..
done
