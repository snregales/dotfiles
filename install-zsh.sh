
sudo apt update && sudo apt install -y zsh curl git && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd .oh-my-zsh/custom/plugins && \
git submodule add -f https://github.com/zsh-users/zsh-syntax-highlighting.git
git submodule add -f https://github.com/zsh-users/zsh-autosuggestions.git
cd ../themes && git submodule add -f https://github.com/Powerlevel9k/powerlevel9k.git
md .local/share/fonts && cd .local/share/fonts && \
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
md ~/.config/fontconfig/conf.d/ && cd ~/.config/fontconfig/conf.d/ && \
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
fc-cache -vf ~/.local/share/fonts/
cd ~
