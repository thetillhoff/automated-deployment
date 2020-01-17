#!/bin/bash

apt update
apt upgrade -y
apt install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y ansible
