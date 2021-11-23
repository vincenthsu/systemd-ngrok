## Installation

1. Clone this repository to the target machine (eg: Raspberry Pi)
2. Get your `authtoken` from ngrok website
3. Inspect and modify the configuration file `ngrok.yml`, by default this config will use _Asia Pacific_ region to serve both **HTTP** and **TCP** tunnels
4. Run `sudo ./install.sh <your_authtoken>`, replace `<your_authtoken>` with the token you've obtained before from ngrok website.
5. You're good to go!

_NB : this repository is forked from [vincenthsu/systemd-ngrok](https://github.com/vincenthsu/systemd-ngrok) with architecture auto-detect feature_
