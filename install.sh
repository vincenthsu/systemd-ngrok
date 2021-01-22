#!/usr/bin/env bash

if [ ! $(which wget) ]; then
    echo 'Please install wget package'
    exit 1
fi

if [ ! $(which git) ]; then
    echo 'Please install git package'
    exit 1
fi

if [ ! $(which unzip) ]; then
    echo 'Please install zip package'
    exit 1
fi

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi

if [ ! -e ngrok.service ]; then
    git clone --depth=1 https://github.com/vincenthsu/systemd-ngrok.git
    cd systemd-ngrok
fi
cp ngrok.service /lib/systemd/system/
mkdir -p /opt/ngrok
cp ngrok.yml /opt/ngrok
sed -i "s/<add_your_token_here>/$1/g" /opt/ngrok/ngrok.yml

cd /opt/ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-amd64.zip
rm ngrok-stable-linux-amd64.zip
chmod +x ngrok

systemctl enable ngrok.service
systemctl start ngrok.service
