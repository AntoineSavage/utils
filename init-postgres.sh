#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

sudo apt update
sudo apt install -y postgresql postgresql-contrib

rm -rf temp
mkdir temp
cd temp

curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip

echo 'postgres:postgres' | sudo chpasswd
sudo service postgresql start
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "create database dvdrental;"
sudo -u postgres pg_restore --dbname=dvdrental --verbose dvdrental.tar
sudo service postgresql stop

cd ..
rm -rf temp
