#!/bin/sh

echo -n "Installing docker"

if [ ! -f /usr/bin/docker ]; then
  apt-get remove -qq -y docker docker.io
  apt-get update -qq -y
  apt-get install -qq -y \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  apt-get update -qq -y
  apt-get install -qq -y docker-ce

  sudo usermod -aG docker vagrant

  echo "docker installed!"
else
  echo "docker is already installed!"
fi

if [ ! -f /etc/init/docker.override ]; then
  echo 'manual' | tee /etc/init/docker.override
fi
