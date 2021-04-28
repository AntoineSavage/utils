#!/bin/bash

if [ `whoami` != 'root' ]; then echo "This program must be run using 'sudo'"; exit; fi

apt update
apt install -y python3-pip