#!/bin/bash
echo "Installing ruby..." > log
sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential
