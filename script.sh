#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install
cd bbb-install/

./bbb-install.sh -v xenial-220 -s bbb.krletron.tk -e krle@tilda.center -g

echo "Create Admin account:"
echo "docker exec greenlight-v2 bundle exec rake user:create["name","email","password","admin"]"
