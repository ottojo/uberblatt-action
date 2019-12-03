#!/bin/bash
REPO_DIR="$(pwd)"
DEPLOY_DIR="$REPO_DIR/build"
ARTIFACT_PREFIX="ARTIFACTS:"

echo "Creating deploy directory: $DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

echo "<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8" />
    <title>$GITHUB_REPOSITORY</title>
</head>
<body>
    <h1>$GITHUB_REPOSITORY</h1>
    <ul>" > $DEPLOY_DIR/index.html

for directory in */; do

    if [[ $directory == *"build" ]]; then
        continue
    fi

    echo "Building $directory"
    cd $REPO_DIR/$directory
    ARTIFACTS=$(make | grep "$ARTIFACT_PREFIX")
    ARTIFACTS=${ARTIFACTS#"$ARTIFACT_PREFIX"}
    echo "Build artifacts: $ARTIFACTS"

    mkdir -p $(dirname "$DEPLOY_DIR/$directory/$artifact")

    for artifact in $(echo $ARTIFACTS | sed "s/,/ /g"); do
        cp "$REPO_DIR/$directory/$artifact" "$DEPLOY_DIR/$directory/$artifact"
        echo "        <li><a href=\"$directory$artifact\">$directory$artifact</a></li>" >> $REPO_DIR/index.html
    done
    
done

echo "    </ul>
</body>
</html>" >> $DEPLOY_DIR/index.html
