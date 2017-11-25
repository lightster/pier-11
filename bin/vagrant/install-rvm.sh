#!/bin/bash

set -e

if ! which rvm ; then
  apt-get update -qq -y
  apt-get install -qq -y software-properties-common

  apt-add-repository -y ppa:rael-gc/rvm 2>&1
  apt-get update -qq -y
  apt-get install -qq -y rvm

  usermod -aG rvm ubuntu

  source /etc/profile.d/rvm.sh

  rvm install --quiet-curl 2.4.1
  rvm use 2.4.1
  gem install bundler -q
fi
