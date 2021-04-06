#!/bin/bash
# this script is called by init-linux.sh

# pg_ctlcluster 13 main start
psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"
# psql -c 'create database dvdrental;'

# curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
# unzip dvdrental.zip
# rm dvdrental.zip

# pg_restore --dbname=dvdrental --verbose dvdrental.tar
# rm dvdrental.tar

rm init-postgres.sh
