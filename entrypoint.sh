#!/bin/bash

pwd
tree
ls -lah /root
ls -lah /
env


OUT_DIR="$RUNNER_TEMP/build"
cd $RUNNER_WORKSPACE
for directory in */; do
    cd $RUNNER_WORKSPACE/$directory
    mkdir -p $OUT_DIR/$directory
    latexmk -pdf -output-directory=$OUT_DIR/$directory
    # Remove every output that isn't a PDF
    find $OUT_DIR/$directory -type f ! -name "*.pdf" -exec rm {} \;
done

cd $RUNNER_WORKSPACE
git checkout gh-pages || git checkout -b gh-pages
cp -r $OUT_DIR/* ./
git commit -a -m "CI update for commit $GITHUB_SHA"
git push
