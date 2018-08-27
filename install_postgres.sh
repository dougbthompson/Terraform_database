#!/bin/bash -e

# Postgres install for "Postgres 9.6 + PostGIS 2.3"

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list' 

sudo apt-get update
sleep 5

sudo apt-get install -y postgresql-9.6

sudo -u postgres createuser -P gisdata (password for gisdata: "gisdata")
sudo -u postgres createdb -O gisdata gisdata

sudo apt install -y postgis postgresql-9.6-postgis-2.3

sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" gisdata

