#!/bin/bash
# install Oh My Zsh, if not set 

if ! [ -x $(command -v zsh) ]; then
	if [ -z ${DOT_PATH} ]; then
    	echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    	exit 1
	fi
	echo "Install pre requirements"
	${DOT_PATH}/scripts/package_manager.sh zsh
fi

FONT_PATH="${HOME}/.local/share/fonts"
FIRA_FONT_PATH="${FONT_PATH}/Fira Code Regular Nerd Font Complete Mono.ttf"

# install FiraCode nerdfont patch
if ! [[ -f ${FIRA_FONT_PATH} ]] ; then
	echo "Adding Fira Code Nerd Font Patch"
	mkdir -p ${FONT_PATH}
	cd ${FONT_PATH}
	curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf > "Fira Code Regular Nerd Font Complete Mono.ttf" 
	cd -
fi

if ! [ -d ${HOME}/.oh-my-zsh ]; then
	# install Antigen
	if ! [ -f ${HOME}/antigen.zsh ]; then
		echo "Install antigen"
		curl -L git.io/antigen > antigen.zsh
	fi

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if ! [[ "$(grep $USER /etc/passwd)" =~ "$(which zsh)" ]]; then
	echo "Changing default shell to zsh"
	sudo chsh -s $(which zsh) ${USER}
fi

