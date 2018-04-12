#!/bin/bash

echo 'GitLab Redis Master Instance.' | sudo tee /etc/motd

#disable selinux
sudo sed -i  s/SELINUX=enforcing/SELINUX=permissive/ /etc/selinux/config
setenforce 0

sudo sysctl vm.overcommit_memory=1

# add this later to /etc/sysctl.conf
# vm.overcommit_memory = 1

# stop and disable postfix
systemctl stop postfix.service
systemctl disable postfix.service

# update the instance.
yum update -y

#install redis
yum install -y redis

# just to make sure they are not running
systemctl stop redis
systemctl stop redis-sentinel

# add firewalld service config file.
# see https://gist.github.com/nexdrew/14392032ed6f105474a3
# use a \ to work around cp -i alias. 
# see https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
\cp /root/redis/redis.xml /etc/firewalld/services/redis.xml

# restart firewalld
systemctl restart firewalld

# add firewalld rules for redis and reload
firewall-cmd --permanent --add-service=redis

firewall-cmd --reload

#change the redis password
sed -i -e "s/requirepass\sfoobared/requirepass ${redis_password}/g" /root/redis/redis.conf
sed -i -e "s/masterauth\sfoobared/masterauth ${redis_password}/g" /root/redis/redis.conf

#overwrite the redis config and reset permissions
# use a \ to work around cp -i alias. 
# see https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
\cp /root/redis/redis.conf /etc/redis.conf
chown redis:root /etc/redis.conf

# # start the redis service
# systemctl enable redis
# systemctl restart redis