#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

# # Add the environment variable for DB_HOST to the bashrc
# echo "export DB_HOST=192.168.10.150" >> ~/.bashrc
#
# # Resource the bashrc to the terminal
# source ~/.bashrc

# # Go to the app
# cd /home/ubuntu/app
#
# # Install the dependancies
# npm i
#
# # Run the app
# node app.js
