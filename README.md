# Pier 11
Pier 11 is my experimental Vagrant machine for building and utilizing development Docker containers, particularly when running macOS as a guest machine.

## Vision
My motivation is to create an easy to setup environment for running development Docker containers without experiencing
[a dramatic I/O slowdown of mounted volumes](https://forums.docker.com/t/file-access-in-mounted-volumes-extremely-slow-cpu-bound/8076/276) that exists in Docker when running on macOS.

I also consider it unacceptable as a developer to need to rebuild a container between making a code change and running tests.  I want to be able to test changes quickly and not wait for a build to finish.

As I began to brainstorm ways to do achieve this, I also recognized I did not want the overhead of deciding if I needed to SSH into a VM to run a command or to run it on the host machine.  I have maintained a Vagrant development environment at work for a few years, and I often have asked (and been asked):

> I need to run `git clone` on my Mac? I should run `docker-compose` on the VM? What about the `make` command—should I run that on the VM or my Mac?

So the three primary inconveniences I was trying to avoid were:

1. Experiencing a dramatic I/O slowdown
2. Needing to rebuild my containers after each code change
3. Deciding whether I needed to be SSH’d into a VM before running a command

I decided that to avoid the dramatic I/O slowdown of mounted volumes on macOS without having to rebuild my containers constantly, I would need to run my containers on a VM.  In order to also avoid inconvenience #3, I decided I would build relatively simple tools that I can run on my Mac that act as a proxy to run commands on the VM.

Born were [`pier` and `moor` command line tools](https://github.com/lightster/pier-cli).

## Requirements
Before installing Pier 11, you will need to download and install:

 - [Vagrant](https://www.vagrantup.com/)
 - [VirtualBox](https://www.virtualbox.org/)

If you have [Brew](https://brew.sh/), you can install Vagrant and Virtualbox via Brew:

```bash
brew cask install vagrant
brew cask install virtualbox
```

## Installation

```bash
git clone git@github.com:lightster/pier-11.git

cd pier-11
make install
```

Additionally, if you want to be able to use `moor cd` to change directories between projects, make sure to add the following to your `~/.bashrc`:

```bash
source /path/to/pier-11/codebase/lightster/pier-cli/bin/bash_functions.sh
```
