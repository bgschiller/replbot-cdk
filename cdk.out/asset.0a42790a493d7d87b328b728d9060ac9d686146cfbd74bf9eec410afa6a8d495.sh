#!/bin/bash -xe

# Update with optional user data that will run on instance start.
# Learn more about user-data: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo yum install -y tmux golang
sudo useradd replbot
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker replbot
newgrp docker
go get -u heckel.io/replbot
sudo cp replbot/config/replbot.service /etc/systemd/system/
sudo cp replbot/replbot /usr/bin
sudo cp -R replbot/config /etc/replbot


