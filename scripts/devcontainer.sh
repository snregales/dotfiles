#!/bin/bash

if [ -z ${DOT_PATH} ]; then
    echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    exit 1
fi

${DOT_PATH}/scripts/link_them.sh
${DOT_PATH}/scripts/setup_zsh_profile.sh
${DOT_PATH}/scripts/dev-tools.sh -d
