FROM debian:8.0
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.1
# The following docker file perform E2E development setup to OpenSAF installation 
#   Momements contain download development packages; download OpenSAF source code; compile; install and finally remove the development packages and the build result
#
# How to run container from this image:
# NODE=SC-1 && docker run --privileged -t --name $NODE -h $NODE -i <img-id> 
# /etc/init.d/opensafd start
#
# It is though better to run it as daemon
# NODE=SC-1 && docker run --privileged -d --name $NODE -h $NODE -i <img-id>
#
# Then enter container using nsenter (just google it and install it)
# PID=`docker inspect --format {{.State.Pid}} SC-1`
# sudo nsenter --target $PID --mount --uts --ipc --net --pid
#
# Shared fs if you have two controllers. The setup-opensaf-node will check for this dir and use that instead.
# Additional use -v /home/adrian/sharedfs:/etc/opensaf/sharedfs and then configure IMM PBE to use this directory persisting IMM data
#

RUN mkdir -p /home/opensaf
WORKDIR /home/opensaf

# Add binaries and scripts needing for runtime
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/home/opensaf/setup-opensaf-node /home/opensaf/setup-opensaf-node
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

# Add helper build scripts 
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/download-opensaf /home/opensaf/download-opensaf
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/configure-opensaf-basic /home/opensaf/configure-opensaf-basic
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/install-opensaf /home/opensaf/install-opensaf

RUN chmod u+x /home/opensaf/* && \
    chmod u+x /sbin/tipc-config

# make sure the package repository is up to date
RUN apt-get update

# Packages for useability
RUN apt-get install -y vim less && \
    apt-get clean

# Packages needed for for runtime. Python is only used for generation of initial xml; but also for cluster resize.
RUN apt-get install -y sudo net-tools sqlite3 libxml2 psmisc procps python kmod && \
    apt-get clean  

# Packages for development. Branch "default" will be build, which is the latest. One can also use opensaf-4.5.x | opensaf-4.4.x | opensaf-4.3.x instead. 
RUN apt-get install -y mercurial gcc g++ libxml2-dev automake m4 autoconf libtool pkg-config make python-dev libsqlite3-dev && \
    apt-get clean && \
    echo "# Download and build OpenSAF" && \
    cd /home/opensaf && \
    ./download-opensaf && \
    ./configure-opensaf-basic opensaf-4.6.x && \
    ./install-opensaf && \
    rm -rf /home/opensaf/opensaf-* && \
    echo "# Remove development packages" && \
    apt-get remove -y mercurial gcc g++ libxml2-dev automake m4 autoconf libtool pkg-config make python-dev libsqlite3-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /home/opensaf/download-opensaf && \
    rm -rf /home/opensaf/configure-opensaf-basic && \
    rm -rf /home/opensaf/install-opensaf && \
    sed '/\. \/lib\/lsb\/init-functions/ a\\/home\/opensaf\/setup-opensaf-node' -i /etc/init.d/opensafd

RUN groupadd opensaf && \
 useradd -r -g opensaf -d /var/run/opensaf -s /sbin/nologin -c "OpenSAF" opensaf && \
 echo '%{opensaf_user} ALL = NOPASSWD: /sbin/reboot, /sbin/tipc-config, /usr/bin/pkill, /usr/bin/killall' >> /etc/sudoers && \
 echo 'Defaults:%opensaf !requiretty' >> /etc/sudoers && \
 echo 'Defaults:opensaf !requiretty' >> /etc/sudoers

ENV container docker

CMD    ["/bin/bash"]
