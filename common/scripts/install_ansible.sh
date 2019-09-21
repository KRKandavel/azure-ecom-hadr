#!/bin/bash



## Update and upgrade the packages

sudo apt update && sudo apt dist-upgrade -y

sudo apt install software-properties-common

## Install pre-requisite packages

sudo apt install -y libssl-dev libffi-dev python-dev python-pip

sudo apt-add-repository --yes --update ppa:ansible/ansible

## Install Ansible and Azure SDK via pip

sudo apt install ansible

sudo pip install ansible[azure]

##install azure cli
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo az aks install-cli

## install Docker client
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

##install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

## Create a credentials file to store azure credentials

## sudo mkdir ~/.azure

## sudo touch ~/.azure/credentials

##$ sudo apt update
##$ sudo apt install software-properties-common
##$ sudo apt-add-repository --yes --update ppa:ansible/ansible
##$ sudo apt install ansible

iptables -A INPUT -p tcp -m tcp --dport 9090 -j ACCEPT
iptables-save

sudo apt install -y redis-tools

sudo apt-get install -y mysql-client

#sudo apt-get install -y mysql-connector-python

#wget http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python_2.1.8-1ubuntu18.04_all.deb
#dpkg -i mysql-connector-python_2.1.8-1ubuntu18.04_all.deb
#wget http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities_1.6.5-1ubuntu16.04_all.deb
#dpkg -i mysql-utilities_1.6.5-1ubuntu16.04_all.deb

