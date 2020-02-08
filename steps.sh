sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh curl gcc vim tree ranger fonts-firacode flatpak
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
curl https://pyenv.run | bash && pyenv install 3.7.6
curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt install -y nodejs
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
cd .oh-my-zsh/custom/plugins
git submodule add -f https://github.com/zsh-users/zsh-syntax-highlighting.git
git submodule add -f https://github.com/zsh-users/zsh-autosuggestions.git
cd ../themes && git submodule add -f https://github.com/Powerlevel9k/powerlevel9k.git
md .local/share/fonts && cd .local/share/fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
md ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d
fc-cache -vf ~/.local/share/fonts/
exec $SHELL
