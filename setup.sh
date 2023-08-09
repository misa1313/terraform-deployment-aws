#!/bin/bash

sudo dnf upgrade --releasever=2023.1.20230725 -y
sudo dnf install python3-pip -y
pip3 install ansible
aws s3 cp s3://webserver-config-bucket/index.html /home/ec2-user/index.html
aws s3 cp s3://webserver-config-bucket/webserver-play.yaml /home/ec2-user/webserver-play.yaml
ansible-playbook /home/ec2-user/webserver-play.yaml
