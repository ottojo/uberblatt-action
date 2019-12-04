# Uberblatt
This action runs `make` in every sub-directory of the repository.
It also lists the generated files in a `index.html` file and saves everything to the `build` directory.
To know which files to deploy, the Makefile shall print `ARTIFACTS:` followed by a comma separated list of file names that should be deployed to stdout:

```Makefile
all: Pflichtenheft.pdf
	$(info ARTIFACTS:Pflichtenheft.pdf)
...
```

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
      uses: actions/checkout@v4
    - name: Compile and Deploy LaTeX to PDF
      uses: ottojo/uberblatt-action@v2
    - name: GitHub Pages Deploy
      uses: maxheld83/ghpages@v0.2.1
      env:
        BUILD_DIR: "build/"
        GH_PAT: ${{ secrets.GH_PAT }}
```
