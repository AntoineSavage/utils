#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

echo "===================="
echo "Getting authorization"
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

echo "===================="
echo "Create temp directory"
rm -rf init-postgres-tmp
mkdir init-postgres-tmp
cd init-postgres-tmp

echo "===================="
echo "Upgrade apt"
sudo apt update
sudo apt upgrade -y

echo "===================="
echo "Install postgresql"
sudo apt install -y postgresql postgresql-contrib

echo "===================="
echo "Init postgres DB"
rm -rf temp
mkdir temp
cd temp
echo 'postgres:postgres' | sudo chpasswd
sudo service postgresql start
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "create database dvdrental;"
curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
sudo -u postgres pg_restore --dbname=dvdrental --verbose dvdrental.tar
sudo service postgresql stop
cd ..
rm -rf temp

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-postgres-tmp
rm init-postgres.sh
kill "$refresh_sudo"
