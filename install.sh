sudo apt update
sudo apt upgrade -y
export DOTFILE="$(sudo find / -type d -name 'dotfiles')"
sudo apt install -y curl gcc vim tree ranger fonts-firacode
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
$DOTFILE/install-docker.sh && \
$DOTFILE/install-flatpak.sh && \
$DOTFILE/install-node.sh && \
$DOTFILE/install-zsh.sh
curl https://pyenv.run | bash && pyenv install 3.7.6
exec $SHELL
