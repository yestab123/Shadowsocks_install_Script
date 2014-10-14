#!/bin/bash

echo " Centos Shadowsocks Install Shell"
echo " Ver 1.0"

echo ""
echo "Install python-pip python-m2crypto supervior and shadowsocks now..."


yum install m2crypto python-setuptools supervisor
easy_install pip
pip install shadowsocks

file="{
    \"server\":\"0.0.0.0\",
    \"server_port\":12888,
    \"local_address\": \"127.0.0.1\",
    \"local_port\":1080,
    \"password\":\"3810171\",
    \"timeout\":600,
    \"method\":\"aes-256-cfb\",
    \"fast_open\": false,
    \"workers\": 12
}"

echo "creating file /etc/shadowsocks.json"
echo "$file" > /etc/shadowsocks.json

super="[program:shadowsocks]
command=ssserver -c /etc/shadowsocks.json
autorestart=true
user=nobody"

echo "creating file /etc/supervisor/conf.d/shadowsocks.conf"
echo "$super" > /etc/supervisor/conf.d/shadowsocks.conf

echo "Setting ulimit now..."
echo "ulimit -n 512000" >> /etc/default/supervisor

echo "Setting iptables..."
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 12888 -j ACCEPT 
service iptables save

echo "Install Finish"
echo "Now starting service..."
service supervisor start
supervisorctl reload
