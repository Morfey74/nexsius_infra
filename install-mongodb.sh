#!/bin/bash
echo "installing mongo..." >> log
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
if [ $? -eq 0 ]; then
    echo "key added" >> log
fi
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
if [ $? -eq 0 ]; then
     echo "distr added" >> log
fi
sudo apt update && sudo apt install -y mongodb-org

if [$? -eq 0]; then
   echo "Mongo installed" >> log
fi
