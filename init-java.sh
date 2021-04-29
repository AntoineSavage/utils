#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

sudo apt update
sudo apt install -y openjdk-13-jdk maven
