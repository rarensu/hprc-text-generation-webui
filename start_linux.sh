#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# if [[ "$(pwd)" =~ " " ]]; then echo This script relies on Miniconda which can not be silently installed under a path with spaces. && exit; fi

# deactivate existing conda envs as needed to avoid conflicts
{ deactivate && conda deactivate && conda deactivate && deactivate; } 2> /dev/null

OS_ARCH=$(uname -m)
case "${OS_ARCH}" in
    x86_64*)    OS_ARCH="x86_64";;
    arm64*)     OS_ARCH="aarch64";;
    aarch64*)     OS_ARCH="aarch64";;
    *)          echo "Unknown system architecture: $OS_ARCH! This script runs only on x86_64 or arm64" && exit
esac

# config
VENV_DIR="$(pwd)/installer_files/venv"

# create the installer env
if [ ! -e "$VENV_DIR" ]; then
    python3 -m venv --system-site-packages $VENV_DIR
fi

# check if conda environment was actually created
if [ ! -e "$VENV_DIR/bin/python" ]; then
    echo "Virtual environment is empty."
    exit
fi

# environment isolation
export PYTHONNOUSERSITE=1
unset PYTHONPATH
unset PYTHONHOME

# Your Hugging Face Token Here
#export HF_TOKEN=

# activate installer env
source  $VENV_DIR/bin/activate 

# setup installer env
python one_click.py $@
