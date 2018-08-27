#!/bin/bash -e

# MySQL install for "MaridDB (Includes Galera) 10.3
# Password for the root user
MYSQL_ROOT_PASSWORD='ChangeMe172!'

sudo apt-get install -y software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu xenial main'
sudo apt-get update

export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" 

sudo apt-get install -y mariadb-server mariadb-client

sudo groupadd sst
sudo useradd --gid sst sst
sudo echo "sst:sst172" | sudo chpasswd

echo Done!
