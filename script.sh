#!/usr/bin/env bash
NAME=$1

sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install
cd bbb-install/

./bbb-install.sh -v xenial-220 -s $NAME.krletron.tk -e krle@tilda.center -g

echo "How to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

