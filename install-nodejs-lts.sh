#!/bin/bash

# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y curl

# Prompt user for Node.js version, default to 20 if empty
read -p "Enter the Node.js major version you want to install (default: 20): " NODE_VERSION
NODE_VERSION=${NODE_VERSION:-20}

# Install Node.js and npm using NodeSource for specified version
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installations
node -v