#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# if [[ "$(pwd)" =~ " " ]]; then echo This script relies on Miniconda which can not be silently installed under a path with spaces. && exit; fi

# deactivate existing conda envs as needed to avoid conflicts
{ deactivate && conda deactivate && conda deactivate && deactivate; } 2> /dev/null

# config
VENV_DIR="$(pwd)/installer_files/venv"

# environment isolation
export PYTHONNOUSERSITE=1
unset PYTHONPATH
unset PYTHONHOME
#export CUDA_PATH="$VENV_DIR"
#export CUDA_HOME="$CUDA_PATH"

# activate env
source "$VENV_DIR/bin/activate"
# update installer env
python one_click.py --update-wizard && echo -e "\nDone!"
