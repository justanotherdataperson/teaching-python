#!/bin/bash

# Based on https://jupytext.readthedocs.io/en/latest/using-cli.html

# When running on VSCode from Windows, you'll need to start a "bash" terminal rather than PowerShell.
# https://stackoverflow.com/questions/42606837/how-do-i-use-bash-on-windows-from-the-visual-studio-code-integrated-terminal


# ./notebooks/jupytext.sh

notebooks=(
    iteration
)


for n in "${notebooks[@]}"

do

    # Convert from Notebook (.ipynb) to Python (.py)
    # Alternative format: jupytext --to py:percent ./notebooks/"$n".ipynb
    jupytext --output ./notebooks/"$n".py ./notebooks/"$n".ipynb

    # Run ruff linter
    ruff check ./notebooks/"$n".py --fix

    # Convert from Python (.py) to Notebook (.ipynb)
    jupytext --to notebook ./notebooks/"$n".py

    # Delete jupytext python file (just used for linting)
    rm ./notebooks/"$n".py

done

echo "Jupytext sript finished running."
