FROM ubuntu:14.04
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.1
# The following docker file provides build environment for OpenSAF 
#
# How to run container from this image:
# NODE=SC-1 && docker run --privileged --env TIPC=no -t --name $NODE -h $NODE -i <img-id>
# cd /home/opensaf
# ./download-opensaf
# ./configure-opensaf-full
# ./install-opensaf
# /home/opensaf/setup-opensaf-node && /etc/init.d/opensafd start
#
# It is though better to run it as daemon
#
# Then enter container using nsenter (just google it and install it)
# PID=`docker inspect --format {{.State.Pid}} SC-1`
# sudo nsenter --target $PID --mount --uts --ipc --net --pid
#
# Shared fs if you have two controllers. The setup-opensaf-node will check for this dir and use that instead.
# Additional use -v /home/adrian/sharedfs:/etc/opensaf/sharedfs and then configure IMM PBE to use this directory persisting IMM data
#

# make sure the package repository is up to date
RUN apt-get update

# Packages for useability
RUN apt-get install -y vim && \
    apt-get clean

# Packages needed for for runtime
RUN apt-get install -y sqlite3 libxml2 psmisc && \
    apt-get clean

# Packages for development
RUN apt-get install -y mercurial gcc g++ libxml2-dev automake m4 autoconf libtool pkg-config make python-dev libsqlite3-dev rpm && \
    apt-get clean

RUN groupadd opensaf && \
 useradd -r -g opensaf -d /var/run/opensaf -s /sbin/nologin -c "OpenSAF" opensaf && \ 
 echo '%{opensaf_user} ALL = NOPASSWD: /sbin/reboot, /sbin/tipc-config, /usr/bin/pkill, /usr/bin/killall' >> /etc/sudoers && \
 echo 'Defaults:%opensaf !requiretty' >> /etc/sudoers && \
 echo 'Defaults:opensaf !requiretty' >> /etc/sudoers

ENV container docker

# Add helper build scripts
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/download-opensaf /home/opensaf/download-opensaf
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/configure-opensaf-basic /home/opensaf/configure-opensaf-basic
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/configure-opensaf-full /home/opensaf/configure-opensaf-full
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/install-opensaf /home/opensaf/install-opensaf
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/doall-opensaf /home/opensaf/doall-opensaf

# Add binaries and scripts needing for runtime
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/home/opensaf/setup-opensaf-node /home/opensaf/setup-opensaf-node
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

RUN chmod u+x /home/opensaf/* && chmod u+x /sbin/tipc-config

CMD    ["/bin/bash"]
