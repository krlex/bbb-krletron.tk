#!/usr/bin/env bash

#echo "Add Your Email: "
#read email
#echo "Your Email is: $email"
#
#echo  "Add Username: "
#read username
#echo "Your Username is: $username"
#
#echo "Add Password: "
#read password
#echo "I don't wanna show you"
#
#echo "Add Subname: "
#read subname
#echo "Your Subname is: $subname"
#
#echo "Add Domain name: "
#read domainname
#echo "Your Domain is: $domainname"

sudo apt update
sudo apt upgrade -y
sudo apt install -y git vim tmux
git clone https://github.com/bigbluebutton/bbb-install


./bbb-install/bbb-install.sh -v xenial-220 -s "class"."sysadmins.cf" -e "krle@tilda.center" -g

echo "How to create Admin account:"
echo "https://docs.bigbluebutton.org/greenlight/gl-admin.html#creating-an-administrator-account"

docker exec greenlight-v2 bundle exec rake user:create["tilda","krle@tilda.center","$password","admin"]
