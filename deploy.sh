#!/bin/bash
echo "cloning reddit" >> log
git clone -b monolith https://github.com/express42/reddit.git
if [ $? -eq 0 ]; then
   echo "cloned. Try to bundle gems" >> log
fi

cd reddit && bundle install
if [ $? -eq 0 ]; then
   echo "gems bundeled. Try to start puma" >> log
fi
puma -d
if [ $? -eq 0 ]; then
   echo "puma startred" >> log
fi
