#!/bin/bash

echo "please wait while I am setting up your enviorement"

# 
apt-get update > /dev/null 2>&1
# Setting up web server
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www
