#!/bin/bash


free -m
sync
sleep 1
echo 3 > /proc/sys/vm/drop_caches
free -m

#To free pagecache:
#* echo 1 > /proc/sys/vm/drop_caches
#To free dentries and inodes:
#* echo 2 > /proc/sys/vm/drop_caches
#To free pagecache, dentries and inodes:
#* echo 3 > /proc/sys/vm/drop_caches
