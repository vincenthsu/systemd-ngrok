# Installation


Step 1: Place [`ngork`](https://ngrok.com/download) in `/opt/ngrok/`

Step 2: Get `authtoken` from ngrok website, then add it to `/opt/ngrok/ngrok.yml`

Step 3: Add `ngork.service` to `/etc/systemd/system/`

Step 4: Start ngork service by typing:
```
    systemctl daemon-reload
    systemctl enable ngrok.service
    systemctl start ngrok.service
```
