#!/usr/bin/env bash

export USERNAME=$1
export PASSWD=$2
export SUB=$3
export DOMAIN=$4
export EMAIL=$5

sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install


./bbb-install/bbb-install.sh -v xenial-220 -s "$SUB"."$DOMAIN" -e "$EMAIL" -g

echo "How to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

docker exec greenlight-v2 bundle exec rake user:create["$USERNAME","$EMAIL","$PASSWD","admin"]
