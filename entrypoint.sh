#!/bin/bash
REPO_ROOT="$(pwd)"
OUT_DIR="$(pwd)/build"

mkdir -p $OUT_DIR

echo "<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8" />
    <title>$GITHUB_REPOSITORY</title>
</head>
<body>
    <h1>$GITHUB_REPOSITORY</h1>
    <ul>" > $OUT_DIR/index.html

for directory in */; do

    if [ "$directory" == "build/" ]; then
        continue
    fi

    echo "Building $directory"
    cd $directory
    mkdir -p $OUT_DIR/$directory
    latexmk -pdf -output-directory=$OUT_DIR/$directory
    # Remove every output that isn't a PDF
    find $OUT_DIR/$directory -type f ! -name "*.pdf" -exec rm {} \;
    FILENAME=$(find $OUT_DIR/$directory -type f -name "*.pdf")
    FILENAME=$(basename "$FILENAME")
    echo "        <li><a href=\"$directory$FILENAME\">$directory$FILENAME</a></li>" >> $OUT_DIR/index.html
done

echo "    </ul>
</body>
</html>" >> $OUT_DIR/index.html
