#! /bin/bash

# Copy the following line:
# wget https://raw.githubusercontent.com/AntoineSavage/utils/main/install_postgres.sh && sh install_postgres.sh && rm install_postgres.sh

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql

sudo /bin/su -c "pg_ctlcluster 13 main start; psql" - postgres
