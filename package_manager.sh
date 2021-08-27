#!/bin/bash

declare -a managers=("apt" "apk" "dnf" "packman")

for item in "${managers[@]}"; do
	manager=$(command -v ${item})
	if [ -x "${manager}" ]; then
		case ${item} in
			apt)
				update="update"
				install="install -y"
				break
				;;
			apk)
				update="update"
				install="add --no-cache"
				break
				;;
			dnf)
				sudo ${manager} install -y $@
				exit 0
				;;
			packman)
				update="-Syy"
				install="-S --noconfirm"
				break
				;;

			*)
				echo "Package manager not found."
		esac
	fi
done

sudo ${manager} ${update} && sudo ${manager} ${install} $@
