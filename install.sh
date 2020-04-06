#!/bin/bash

###################
# Install ansible #
echo "<< Add-repository >>"
sudo apt-add-repository ppa:ansible/ansible

echo "<< update now >>"
sudo apt update
sudo apt install ansible

echo "<< Install ansible >>"
sudo apt install ansible -y 


