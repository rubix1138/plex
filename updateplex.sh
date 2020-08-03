#!/bin/sh
set -e
username=
password=
tempfile=/tmp/plex_newest.deb
curl -c /tmp/cookies -s -X 'POST' -H 'Content-Type: application/x-www-form-urlencoded' -H 'X-Plex-Client-Identifier: 1' -H 'Origin: https://www.plex.tv' -d "user[login]=$username" -d "user[password]=$password" -d "user[remember_me]=1" 'https://plex.tv/users/sign_in.json'
url=$(curl -s -b /tmp/cookies -H "plex_tv_client_identifier=1" -I https://plex.tv/downloads/latest/1\?channel\=8\&build\=linux-ubuntu-x86_64\&distro\=ubuntu | grep -e "^Location" | awk '{print $2}' | sed -e 's/[[:space:]]*$//')
wget -O $tempfile $url
dpkg -i $tempfile
rm -rf $tempfile
