# uberblatt-action
This action runs `latexmk` in every sub-directory of the repository.
It also lists the generated PDF files in a `index.html` file and saves everything to the `build` directory.

This is intended to work with [maxheld83/ghpages](https://github.com/maxheld83/ghpages) to use GitHub-Pages to download the PDFs.

## Example
* [ottojo/SoPra-Exercises](https://github.com/ottojo/SoPra-Exercises)

`.github/workflows/main.yml`
```yaml
name: CI

on: 
  push:
    branches:
      - master

jobs:
  latex:
    runs-on: ubuntu-latest
    steps:
    - name: Set up Git repository
      uses: actions/checkout@v3
    - name: Compile and Deploy LaTeX to PDF
      uses: ottojo/uberblatt-action@v2
    - name: GitHub Pages Deploy
      uses: maxheld83/ghpages@v0.2.1
      env:
        BUILD_DIR: "build/"
        GH_PAT: ${{ secrets.GH_PAT }}
```
