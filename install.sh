#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

sudo apt-get update

if [ ! $(which wget) ]; then
    sudo apt-get install wget -y
fi

if [ ! $(which jq) ]; then
    sudo apt-get install jq -y
fi

if [ ! $(which git) ]; then
   sudo apt-get install git -y
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi

if [ ! -e ngrok.service ]; then
    git clone --depth=1 https://github.com/vincenthsu/systemd-ngrok.git
    cd systemd-ngrok
fi

# determine system arch
ARCH=
if [ "$(uname -m)" == 'x86_64' ]
then
    ARCH=amd64
elif [ "$(uname -m)" == 'aarch64' ]
then
    ARCH=arm64
elif [ "$(uname -m)" == 'i386' ] || [ "$(uname -m)" == 'i686' ]
then
    ARCH=386
else
    ARCH=arm
fi

ARCHIVE=ngrok-v3-stable-linux-$ARCH.tgz
DOWNLOAD_URL=https://bin.equinox.io/c/bNyj1mQVY4c/$ARCHIVE

cp ngrok.service /lib/systemd/system/
mkdir -p /opt/ngrok
cp ngrok.yml /opt/ngrok
sed -i "s/<add_your_token_here>/$1/g" /opt/ngrok/ngrok.yml

cd /opt/ngrok
echo "Downloading ngrok for $ARCH . . ."
wget $DOWNLOAD_URL --no-check-certificate
tar xvf $ARCHIVE
rm $ARCHIVE
chmod +x ngrok

systemctl enable ngrok.service
systemctl start ngrok.service
systemctl status ngrok.service
sleep 5

STATUSNGROK=$(wget http://127.0.0.1:4040/api/tunnels -q -O - | jq '.tunnels | .[] | "\(.name) \(.public_url)"')
echo -e "service online NGROK:\n" $STATUSNGROK

echo "Done installing ngrok"
exit 0
