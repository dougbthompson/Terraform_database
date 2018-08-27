#!/bin/bash -e

# Postgres install for "Postgres 9.6 + PostGIS 2.3"

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list' 
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update
sleep 5

sudo apt-get install -y postgresql-9.6

sudo -u postgres createuser gisdata
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'gisdata';"
sudo -u postgres createdb -O gisdata gisdata

sudo apt install -y postgis postgresql-9.6-postgis-2.3

sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" gisdata

