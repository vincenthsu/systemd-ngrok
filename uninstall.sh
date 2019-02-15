#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

systemctl stop ngrok.service
systemctl disable ngrok.service
rm /lib/systemd/system/ngrok.service
rm -rf /opt/ngrok
