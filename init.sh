#!/bin/bash

# ./init.sh

# Initialise development environment

# Create virtual environment
python3 -m venv ./venv || python -m venv ./venv

# Determine if running Windows environment
running_windows(){
    # Bash scripts can't return a string or boolean variable
    # You have three options:
    # 1. Echo the result (return will automatically use the value of your last command)
    # 2. Return an integer exit status (0 to 255)
    # 3. Share a variable between the function and where the function is called
    os=$(uname)

    is_windows=0

    if [[ $os == *"Windows"* ]]; then
        is_windows=1
    elif [[ $os == *"MINGW"* ]]; then
        is_windows=1
    elif [[ $os == *"CYGWIN"* ]]; then
        is_windows=1
    fi

    # Echo result to ensure it is returned
    echo $is_windows

    return $is_windows
}

is_windows=$(running_windows)

# Activate virtual environment
if [[ $is_windows == 1 ]]; then
    source ./venv/Scripts/activate  # Windows
else
    source ./venv/bin/activate  # Linux
fi

# Install requirements
pip install -r requirements.txt -r requirements-dev.txt

# Install pre-commit
pre-commit install
