#!/bin/bash
REPO_ROOT="$(pwd)"
OUT_DIR="/tmp/build"

for directory in */; do
    echo "Building $directory"
    cd $directory
    mkdir -p $OUT_DIR/$directory
    latexmk -pdf -output-directory=$OUT_DIR/$directory
    # Remove every output that isn't a PDF
    find $OUT_DIR/$directory -type f ! -name "*.pdf" -exec rm {} \;
    cd ..
done


# Deploy to GitHub Pages
git checkout gh-pages || git checkout -b gh-pages
cp -r $OUT_DIR/* ./
git commit -a -m "CI update for commit $GITHUB_SHA"
git push
