#!/bin/bash

function help() {
	echo "Install development tools. no option will install all tools listed"
	echo
	echo "Syntax: scriptTemplate [-h|d]"
  	echo "options:"
    echo "h     Print this Help."
	echo "d     Install only tools for devcontainer"
    echo
}

function minimal_install() {
	${DOT_PATH}/scripts/package_manager.sh neovim tree 
}

function install_docker() {
	if ! [ -x "$(command -v docker)" ]; then
    	${DOT_PATH}/scripts/package_manager.sh apt-transport-https ca-certificates curl gnupg lsb-release python3.8-venv;
    	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
    	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
    	${DOT_PATH}/scripts/package_manager.sh docker-ce docker-ce-cli containerd.io
    	sudo groupadd docker && sudo usermod -aG docker ${USER};
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
		pye
    	python -V
    fi
}

function install_poetry() {
	if ! [ -d ${HOME}/.local/pipx ]; then
    	python -m pip install -U pip
    	python -m pip install pipx
    	source ${HOME}/.profile
    fi

	if ! [ -x "$(command -v poetry)" ]; then
    	python -m pipx install poetry
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

function install_devcontainer() {
	minimal_install
	install_github
	install_poetry
}

if [ -z ${DOT_PATH} ]; then
    echo "DOT_PATH is not set, this variable gives the path to dotfiles repo"
    exit 1
fi

manager="$(${DOT_PATH}/scripts/package_manager.sh which_package_manager)"

while getopts ":hd:" option; do
	case ${option} in
		h) # help message
			help
			exit;;
		d) # devcontainer environment
			install_devcontainer
			exit;;
		\?) # Invalid option
			echo "Invalid option(s)"
			exit;;
	esac
done

if [ ${OPTIND} -eq 1 ] ; then
	install_devcontainer
	install_pyenv
	install_docker
fi

exec ${SHELL}
