sudo apt update
sudo apt upgrade -y
sudo apt install -y curl gcc vim tree ranger fonts-firacode
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
curl https://pyenv.run | bash && pyenv install 3.7.6
./install-docker.sh && \
./install-flatpak.sh && \
./install-node.sh && \
./install-zsh.sh
