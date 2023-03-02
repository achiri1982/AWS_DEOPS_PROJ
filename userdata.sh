#! /bin/bash

#Install docker
sudo yum update -y
sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

#Install Jenkin
sudo docker run -d -p 8080:8080 -p 5000:5000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11

sudo docker ps -a | grep Up
if echo $? > 0; then
    sudo systemctl start docker
    sudo docker start krazy_kare
fi
