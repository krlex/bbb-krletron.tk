#!/usr/bin/env bash

echo "Add Your Email: "
read email
echo "Your Email is: $email"

echo  "Add Username: "
read username
echo "Your Username is: $username"

stty -echo ; read -p "Add Password: " password; stty echo
echo "I don't wanna show you"

echo "Add Subname: "
read subname
echo "Your Subname is: $subname"

echo "Add Domain name: "
read domainname
echo "Your Domain is: $domainname"

sudo apt update
sudo apt upgrade -y
git clone https://github.com/bigbluebutton/bbb-install
sudo apt install -y git vim tmux


./bbb-install/bbb-install.sh -v xenial-220 -s "$subname"."$domainname" -e "$email" -g

docker exec greenlight-v2 bundle exec rake user:create["$username","$email","$password","admin"]

echo "If you wana know how to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

clear

echo "GO TO:"
echo "https://$subname.$domainname"
