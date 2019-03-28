#!/bin/bash
echo "Installing ruby..." > log
apt update && apt install -y ruby-full ruby-bundler build-essential
