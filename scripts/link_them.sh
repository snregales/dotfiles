#!/bin/bash

function link_file() {
    if [ -f ${HOME}/$1 ] && ! [ -L ${HOME}/$1 ]; then
        echo "Archiving ${HOME}/$1"
        mv ${HOME}/$1 ${HOME}/.archive
    elif [ $(readlink -f ${HOME}/$1) != ${DOT_PATH}/$1 ] ; then
        echo "Removing existing link not pointing to ${DOT_PATH}/$1"
        rm ${HOME}/$1
    else
        echo "Link already pointing to ${DOT_PATH}/$1"
        return 0
    fi
    echo "Linked to ${DOT_PATH}/$1"
    ln -s ${DOT_PATH}/$1 ${HOME}/$1
}

if [ -z ${DOT_PATH} ]; then
    echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    exit 1
fi

if $(git rev-parse --is-bare-repository); then
    echo "This is a bare repository no linking needed, just make sure your bare repo is cloned on ${HOME}"
    exit 1
fi

mkdir -p ${HOME}/.archive

link_file .p10k.zsh
link_file .zshrc

if [ -f ${HOME}/.profile ] ; then
    mv ${HOME}/.profile ${HOME}/.archive
fi

link_file .zprofile
link_file antigen.zsh

cat << EOF | tee -a ${HOME}/.bash-aliases
alias zshconfig='nvim ${HOME}/.zshrc'
EOF
