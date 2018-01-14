#!/bin/bash
chown -R root:bind /etc/bind
/etc/init.d/rsyslog start
/etc/init.d/bind9 start
/bin/bash
