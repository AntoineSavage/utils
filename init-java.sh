#!/bin/bash

if [ `whoami` != 'root' ]; then echo "This program must be run as 'sudo'"; exit; fi

apt update
apt install -y openjdk-13-jdk maven