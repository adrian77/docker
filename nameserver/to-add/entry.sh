#!/bin/bash
CFG_DIR=/config
[ ! -z $1 ] && CFG_DIR=$1
rm -rf /etc/bind
mkdir /etc/bind
cp -R $CFG_DIR/* /etc/bind
chown -R root:bind /etc/bind
/etc/init.d/rsyslog start
/etc/init.d/bind9 start
while [ true ]; do
  sleep 100
done
