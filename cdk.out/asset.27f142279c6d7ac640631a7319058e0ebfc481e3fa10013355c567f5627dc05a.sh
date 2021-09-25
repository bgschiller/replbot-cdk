#!/bin/bash -xe

# Update with optional user data that will run on instance start.
# Learn more about user-data: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo yum install -y tmux
sudo rpm -ivh https://github.com/binwiederhier/replbot/releases/download/v0.4.5/replbot_0.4.5_amd64.rpm
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker replbot
newgrp docker
