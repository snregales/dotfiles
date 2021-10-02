#!/bin/bash

if [ -z ${DOT_PATH} ]; then
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    export DOT_PATH=$(dirname "${DIR}")
fi

SCRIPTS_PATH=${DOT_PATH}/scripts

if ! [ -f /.dockerenv ] ; then
    ${SCRIPTS_PATH}/setup_zsh_profile.sh
    ${SCRIPTS_PATH}/dev-tools.sh
fi

if [[ $DOT_PATH == $HOME ]] && [ -d $HOME/dotfiles ]; then                                                                                                                   ─╯
  cd $HOME/dotfiles
  [ "$(git rev-parse --is-inside-git-dir)" ] || ${SCRIPTS_PATH}/link_them.sh
  cd -
fi

