#!/bin/bash
# Sends a key to a server to allow the machine to access it
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
# Gets the repo where the versions are bing stored and places it in the apt sources list file
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update the source list
sudo apt-get update -y
# Upgrade the packages we have already
# sudo apt-get upgrade -y
# Gets and installs the package
sudo apt-get install mongodb-org=3.2.20 -y
# Remove original file
sudo rm /etc/mongod.conf
# Create and link file with the mongod file
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf
# Tells the system to start the service
sudo systemctl restart mongod
# Tells the system to start the service on startup
sudo systemctl enable mongod


# Other, but less secure, way of doing the above
# Replaces the bind_ip with 0.0.0.0 for the DB to listen on that IP
# sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
# Tells the system to restart the service
# sudo systemctl restart mongod.service
