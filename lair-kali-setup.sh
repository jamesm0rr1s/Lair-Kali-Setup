#! /bin/bash

# sudo bash /opt/jamesm0rr1s/Lair-Setup/lair-kali-setup.sh

#curl -fsSL https://get.docker.com -o get-docker.sh
#sh get-docker.sh

# Remove any existing docker packages and update the package list
apt remove -y docker docker-engine docker.io
apt update

# Install apt HTTPS packages
apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Add stable repo
echo 'deb https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list

# Update repo list
apt update

# Finally, install docker Community Edition
apt install -y docker-ce docker-ce-cli containerd.io

# Add kali user to Docker group
usermod -aG docker kali

# Logout

# Download Docker compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make executable
chmod +x /usr/local/bin/docker-compose

# Create symbolic link
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Lair
git clone https://github.com/ryhanson/lair-docker.git /opt/Lair-Docker
cd /opt/Lair-Docker/
systemctl start docker
docker-compose build
docker-compose up