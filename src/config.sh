#!/bin/bash -xe

# Update with optional user data that will run on instance start.
# Learn more about user-data: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html

sudo yum update -y
sudo amazon-linux-extras install docker tmux
sudo service docker start
wget --no-clobber https://github.com/binwiederhier/replbot/releases/download/v0.1.2/replbot_0.1.2_amd64.rpm
sudo yum install replbot_0.1.2_amd64.rpm
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker replbot


