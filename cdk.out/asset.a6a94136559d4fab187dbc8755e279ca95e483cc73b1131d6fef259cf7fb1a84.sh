#!/bin/bash -xe

# Update with optional user data that will run on instance start.
# Learn more about user-data: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start

# install old tmux, to convince rpm that I have tmux installed
sudo yum install -y tmux

# install an up-to-date tmux from source, because
# we need a newer version to run replbot.
# 1. install deps
sudo yum install -y gcc kernel-devel make ncurses-devel

# 2. DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
curl -LOk https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
tar -xf libevent-2.1.11-stable.tar.gz
cd libevent-2.1.11-stable
./configure --prefix=/usr/local
make
sudo make install

# 3. DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL

curl -LOk https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
tar -xf tmux-3.0a.tar.gz
cd tmux-3.0a
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install

sudo rpm -ivh https://github.com/binwiederhier/replbot/releases/download/v0.4.5/replbot_0.4.5_amd64.rpm
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker replbot
newgrp docker
sudo systemctl enable replbot
