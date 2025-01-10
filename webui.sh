#!/usr/bin/env bash
#################################################
# Please do not make any changes to this file,  #
# change the variables in webui-user.sh instead #
#################################################

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Read variables from webui-user.sh
# shellcheck source=/dev/null
if [[ -f "$SCRIPT_DIR"/webui-user.sh ]]
then
    source "$SCRIPT_DIR"/webui-user.sh
fi

# Set defaults
# Install directory without trailing slash
if [[ -z "${install_dir}" ]]
then
    install_dir="$SCRIPT_DIR"
fi

# Name of the subdirectory (defaults to stable-diffusion-webui)
if [[ -z "${clone_dir}" ]]
then
    clone_dir="text-generation-webui"
fi

# git executable
if [[ -z "${GIT}" ]]
then
    export GIT="git"
else
    export GIT_PYTHON_GIT_EXECUTABLE="${GIT}"
fi

if [[ -z "${LAUNCH_SCRIPT}" ]]
then
    LAUNCH_SCRIPT="start_linux.sh"
fi

cd "${install_dir}"/ || { printf "\e[1m\e[31mERROR: Can't cd to %s/, aborting...\e[0m" "${install_dir}"; exit 1; }

if [[ -d "${clone_dir}" ]]
then
    cd "${clone_dir}"/ || { printf "\e[1m\e[31mERROR: Can't cd to %s/%s/, aborting...\e[0m" "${install_dir}" "${clone_dir}"; exit 1; }
else
    printf "\n%s\n" "${delimiter}"
    printf "Clone text-generation-webui"
    printf "\n%s\n" "${delimiter}"
    "${GIT}" clone $SCRIPT_DIR "${clone_dir}"
    cd "${clone_dir}"/ || { printf "\e[1m\e[31mERROR: Can't cd to %s/%s/, aborting...\e[0m" "${install_dir}" "${clone_dir}"; exit 1; }
    git checkout HPRC
    git remote set-url origin https://github.com/oobabooga/text-generation-webui.git
    # linking llama-2 model from source
    if [[ $LINK_THIS_MODEL ]]
    then
        ln -s $T_ROOT/$LINK_THIS_MODEL models/$LINK_THIS_MODEL
    fi
fi

bash start_linux.sh $LAN_CMD_ARGS $TEXT_GEN_CMD_ARGS 
