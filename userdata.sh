#! /bin/bash

#Install docker
sudo yum update -y
sudo yum -y install docker
sudo systemctl enable docker
sudo sytemctl start docker

#Install Jenkin
sudo docker run -d -p 8080:8080 -p 5000:5000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
