#!/bin/bash

if [ -z ${DOT_PATH} ]; then
    echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    exit 1
fi

SCRIPTS_PATH=${DOT_PATH}/scripts
manager="$(${SCRIPTS_PATH}/package_manager.sh which_package_manager)"

function help() {
	echo "Install development tools. no option will install all tools listed"
	echo
	echo "Syntax: scriptTemplate [-h|e|p|P|g|d]"
  	echo "options:"
    echo "h     Print this Help."
	echo "e     Install essentials"
	echo "p     Install pyenv"
	echo "P     Install poetry"
	echo "g     Install github"
	echo "d     Install docker"
    echo
}

function install_essential() {
	${SCRIPTS_PATH}/package_manager.sh zsh neovim tree fonts-firacode gnupg2
}

function install_docker() {
	if ! [ -x "$(command -v docker)" ]; then
    	${SCRIPTS_PATH}/package_manager.sh apt-transport-https ca-certificates curl gnupg lsb-release python3.8-venv;
    	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
    	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
    	${SCRIPTS_PATH}/package_manager.sh docker-ce docker-ce-cli containerd.io
    	sudo groupadd docker && sudo usermod -aG docker ${USER};
    fi
}

function install_pipx() {
	if ! [ -d ${HOME}/.local/pipx ]; then
    	python3 -m pip install -U pip
    	python3 -m pip install pipx
    	source ${HOME}/.profile
    fi
}

function install_poetry() {
	if ! [ -x "$(command -v poetry)" ]; then
    	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
    fi
}

function install_pyenv() {
	if ! [ -d ${HOME}/.pyenv ]; then
    	case "$(basename -- ${manager})" in
    		apt)
    			sudo ${manager} update && \ 
    			sudo ${manager} install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    			;;
    		apk)
    			${manager} add --no-cache git bash build-base libffi-dev openssl-dev bzip2-dev zlib-dev readline-dev sqlite-dev 
    			;;
	    	dnf)
	    		${manager} install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
	    		;;
	    	pacman)
	    		${manager} -S --needed base-devel openssl zlib xz
	    		;;
    	esac
    	curl https://pyenv.run | bash
		${version} = "$(python3 -V | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')"
    	pyenv install ${version}
		pyenv global ${version}
		[ "$(which python)" == *"${HOME}/.pyenv"* ] install_pipx 
    fi
}

function install_github() {
	if ! [ -x "$(command -v gh)" ]; then
    	case "$(basename -- ${manager})" in
    		apt)
    			curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    			echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
		    	sudo ${manager} update && sudo ${manager} install gh
				;;
    		pacman)
    			sudo ${manager} -S github-cli
    			;;
    		dnf)
    			sudo ${manager} config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && sudo ${manager} install gh
    			;;
    	esac
	fi
}


while getopts ":hepPgd" option; do
	case ${option} in
		h) # help message
			help
			;;
		e) # essiantal (zsh, neovim, tree)
			install_essential
			;;
		p) # pyenv
			install_pyenv
			;;
		P) # poetry
			install_poetry
			;;
		g) # github
			install_github
			;;
		d) # docker
			install_docker
			;;
		\?) # Invalid option
			echo "Invalid option(s)"
			help
			exit;;
	esac
done

if [ ${OPTIND} -eq 1 ] ; then
	install_essential
	install_poetry
	install_pyenv
	install_docker
	install_github
fi

exec ${SHELL}
