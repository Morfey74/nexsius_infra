#!/bin/bash
echo "Installing ruby..." > log
sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential
if [ $? -eq 0 ]; then
   echo "ruby successfuly installed" >> log
fi
