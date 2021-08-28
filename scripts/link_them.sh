#!/bin/bash

function link_file() {
    [ -L ${HOME}/$1 ] && rm -r ${HOME}/$1
    [ -f ${HOME}/$1 ] && rm mv ${HOME}/$1 ${HOME}/.archive
    echo "Linked to ${DOT_PATH}/$1"
    ln -s ${DOT_PATH}/$1 ${HOME}/$1
}

if [ -z ${DOT_PATH} ]; then
    echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    exit 1
fi

if [[ $DOT_PATH == $HOME ]] && [ -d $HOME/dotfiles ]; then                                                                                                                   ─╯
  cd $HOME/dotfiles
  [ "$(git rev-parse --is-inside-git-dir)" ] && exit 0
  cd -
fi


mkdir -p ${HOME}/.archive

link_file .p10k.zsh
link_file .zshrc

[ -f ${HOME}/.profile ] && mv ${HOME}/.profile ${HOME}/.archive

link_file .zprofile
link_file antigen.zsh

cat << EOF | tee -a ${HOME}/.bash-aliases
alias zshconfig='nvim ${HOME}/.zshrc'
EOF
