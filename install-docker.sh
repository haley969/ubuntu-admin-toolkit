echo
echo "This script installs Docker and Docker Compose"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"
echo

echo
echo "Installing prerequesites"
echo
sudo apt update
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

echo
echo "Adding Docker repository"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo
echo "Installing Docker"
echo
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y

echo
echo "Installing Docker Compose"
echo
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
