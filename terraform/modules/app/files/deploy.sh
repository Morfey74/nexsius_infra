#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

sudo mv /tmp/puma-server.service /etc/systemd/system/puma-server.service
sudo systemctl start puma-server
sudo systemctl enable puma-server

