tools="git curl neovim zsh tree mlocate ranger"

if [ -x "$(command -v apt)" ]; then
	sudo apt update
	sudo apt install -y ${tools}
elif [ -x "$(command -v apk)"]; then
	sudo apk update
	sudo apk add --no-cache ${tools}
elif [ -x "$(command -v dnf)"]; then
	sudo dnf install -y git
elif [ -x "$(command -v packman)" ]; then
	sudo packman -Syy
	sudo packman -S --noconfirm ${tools}
else
	echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: ${tools}">&2;
fi	
