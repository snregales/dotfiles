#!/bin/bash

function which_package_manager() {
	local managers=("apt" "apk" "dnf" "packman")
	for item in "${managers[@]}"; do
		local manager=$(command -v ${item})
		if [ -x "${manager}" ]; then
			echo "${manager}"
			break
		fi
	done
}

function install() {
	local package_manager="$(which_package_manager)"
	case "$(basename -- ${package_manager})" in
		apt)
			update="update"
			install="install -y"
			;;
		apk)
			update="update"
			install="add --no-cache"
			;;
		dnf)
			sudo ${package_manager} install -y $@
			exit 0
			;;
		packman)
			update="-Syy"
			install="-S --noconfirm"
			;;
		*)
			echo "Package manager not found."
	esac
		
	sudo ${package_manager} ${update} && sudo ${package_manager} ${install} $@
}

case $1 in
	which_package_manager) which_package_manager; exit;;
	*) install $@; exit;;
esac
