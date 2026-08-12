#!/bin/bash
set -e

echo "Installing Ansible on Bastion..."
sudo apt-get update
sudo apt-get install -y ansible

echo "Ansible installation completed."
ansible --version
