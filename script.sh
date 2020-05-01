#!/usr/bin/env bash

USERNAME=$1
PASSWD=$2
SUB=$3
DOMAIN=4
EMAIL=$5


sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install
cd bbb-install/

./bbb-install.sh -v xenial-220 -s $SUB.krletron.tk -e $EMAIL -g

echo "How to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

docker exec greenlight-v2 bundle exec rake user:create["$USENAME","$EMAIL","$PASSWD","admin"]
