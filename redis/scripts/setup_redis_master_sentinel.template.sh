#!/bin/bash

# add firewalld service config file.
# see https://gist.github.com/nexdrew/14392032ed6f105474a3
# use a \ to work around cp -i alias. 
# see https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
\cp /root/redis/redis-sentinel.xml /etc/firewalld/services/redis-sentinel.xml

# restart firewalld
systemctl restart firewalld

# add firewalld rules for redis and reload
firewall-cmd --permanent --add-service=redis-sentinel

firewall-cmd --reload

# configure sentinel
# use null resource to replace 127.0.0.1 after redis is installed
# sed -i -e "s/masterip/127.0.0.1/g" /root/redis/redis-sentinel.conf
sed -i -e "s/foobared/${redis_password}/g" /root/redis/redis-sentinel.conf

# use a \ to work around cp -i alias. 
# see https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
\cp /root/redis/redis-sentinel.conf /etc/redis-sentinel.conf
chown redis:root /etc/redis-sentinel.conf

# # start the redis sentinel service
# systemctl enable redis-sentinel
# systemctl restart redis-sentinel