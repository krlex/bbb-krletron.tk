#!/usr/bin/env bash

echo "Add Your Email: $1";
read $1;

echo  "Add Username: $2";
read $2;

echo "Add Password: $3";
read $3;

echo "Add Subname: $4";
read $4;

echo "Add Domain name: $5";
read $5;

export EMAIL=$1
export USERNAME=$2
export PASSWD=$3
export SUB=$4
export DOMAIN=$5

sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install


./bbb-install/bbb-install.sh -v xenial-220 -s "$SUB"."$DOMAIN" -e "$EMAIL" -g

echo "How to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

docker exec greenlight-v2 bundle exec rake user:create["$USERNAME","$EMAIL","$PASSWD","admin"]
