#!/bin/bash

# Exit on any error
set -e

# Function to print status messages
print_status() {
    echo -e "\n[*] $1"
}

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root or with sudo"
    exit 1
fi

print_status "Updating package index"
apt-get update

print_status "Installing required packages"
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

print_status "Adding Docker's official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

print_status "Setting up Docker repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

print_status "Updating package index again"
apt-get update

print_status "Installing Docker Engine"
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

print_status "Creating docker group (if it doesn't exist)"
groupadd -f docker

print_status "Adding current user to docker group"
# Get the user who ran sudo
SUDO_USER=${SUDO_USER:-$USER}
usermod -aG docker $SUDO_USER

print_status "Enabling and starting Docker service"
systemctl enable docker
systemctl start docker

print_status "Verifying Docker installation"
docker --version

print_status "Testing Docker with hello-world"
docker run hello-world

echo -e "\nDocker has been successfully installed!"
echo "Please log out and log back in for the group changes to take effect."
echo "After logging back in, you can run 'docker ps' to verify the installation."
