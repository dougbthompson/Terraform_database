#!/bin/bash

wget https://repo.percona.com/apt/percona-release_0.1-6.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_0.1-6.$(lsb_release -sc)_all.deb
sudo apt-get update
sudo apt-get install -y debconf-utils
sudo apt-cache search percona
export DEBIAN_FRONTEND=noninteractive
echo "percona-xtradb-cluster-server-5.7 percona-xtradb-cluster-server-5.7/root-pass     password ChangeMe172!" | sudo debconf-set-selections
echo "percona-xtradb-cluster-server-5.7 percona-xtradb-cluster-server-5.7/re-root-pass  password ChangeMe172!" | sudo debconf-set-selections
sudo apt-get install -y percona-xtradb-cluster-57  
  
mysql --user=root --password=ChangeMe172! -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql --user=root --password=ChangeMe172! -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql --user=root --password=ChangeMe172! -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'" 

