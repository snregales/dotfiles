
echo running install-node shell script
root && apt update && apt install curl -y && \
sudo sh -c "curl -sL https://deb.nodesource.com/setup_12.x | bash -" && sudo apt install -y nodejs
