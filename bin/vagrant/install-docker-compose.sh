#!/bin/sh

echo -n "Installing docker-compose"

if [ ! -f /usr/local/bin/docker-compose ]; then
  curl -sS -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  echo "docker-compose installed!"
else
  echo "docker-compose is already installed!"
fi
