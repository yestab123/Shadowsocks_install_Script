#!/bin/bash

sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -s 192.168.0.1/24 -j MASQUERADE
