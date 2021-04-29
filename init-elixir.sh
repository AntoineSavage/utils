#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

sudo apt update
sudo apt install -y elixir
