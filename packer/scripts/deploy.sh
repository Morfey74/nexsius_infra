#!/bin/bash
set -e

cd /opt/
echo "cloning reddit" 
sudo git clone -b monolith https://github.com/express42/reddit.git
sudo chown nexs:nexs reddit && cd reddit && bundle install
cd reddit && bundle install
 
sudo mv /tmp/puma-server.service /etc/systemd/system/

sudo systemctl enable puma-server && sudo systemctl start puma-server
