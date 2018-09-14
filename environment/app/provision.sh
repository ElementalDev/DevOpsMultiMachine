#!/bin/bash

# Update the sources list
sudo apt-get update -y

# Upgrade any packages available
sudo apt-get upgrade -y

# Install nginx
sudo apt-get install nginx -y

# Install git
sudo apt-get install git -y

# Install nodejs
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# Install pm2
sudo npm install pm2 -g

# Create and link file with the default file
sudo ln -s /home/ubuntu/environment/nodeapp.conf /etc/nginx/conf.d/nodeapp.conf

# Restart the server
sudo nginx -s reload

# Go to the app
cd /home/ubuntu/app

# Install the dependancies
npm i
