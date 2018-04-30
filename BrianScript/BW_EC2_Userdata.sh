#!/bin/bash

# move to the ec2-user directory and update yum
cd /home/ec2-user
yum update -y

# Paste the oneagent download link here.  THe following is an example and will not work.
# This downloads the OneAgent installer from your tenant
wget --no-check-certificate -O Dynatrace-OneAgent-Linux.sh "https://zby20160.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token=VtEEO1CpRSu1brjzctgsg&arch=x86&flavor=default"

# Installs One Agent
/bin/sh Dynatrace-OneAgent-Linux.sh APP_LOG_CONTENT_ACCESS=1

#Install and start docker
yum install docker -y
service docker start

#Install docker compse
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker ${USER}

#install git
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel -y

#Clone the easyTravel Dynatrace Docker repo
git clone https://github.com/Dynatrace-BrianWilson/easyTravel-Dynatrace-Docker.git

#Enter the repo and start the containers
cd /home/ec2-user/easyTravel-Dynatrace-Docker
docker-compose up -d
