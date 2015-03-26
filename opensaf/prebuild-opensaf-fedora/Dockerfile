FROM fedora:21 
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.1
#
# How to run container from this image: 
# NODE=SC-1 && docker run --privileged -d --name $NODE -h $NODE -i <img-id>
#
# How to enter container using nsenter (just google it and install it)
# PID=`docker inspect --format {{.State.Pid}} SC-1`
# sudo nsenter --target $PID --mount --uts --ipc --net --pid 
#
# Shared fs if you have two controllers. The setup-opensaf-node will check for this dir and use that instead.
# Additional use -v $HOME/sharedfs:/etc/opensaf/sharedfs and then configure IMM PBE to use this directory persisting IMM data
#

# make sure the package repository is up to date
RUN ls -la /
RUN yum -y update

# Packages for usuability
RUN yum -y install vim && yum clean all

# Packages needed for OpenSAF runtime 
RUN yum -y install net-tools sqlite3 libxml2 redhat-lsb-core initscripts && \
    yum clean all

RUN groupadd opensaf && \
 useradd -r -g opensaf -d /var/run/opensaf -s /sbin/nologin -c "OpenSAF" opensaf && \
 echo 'opensaf ALL = NOPASSWD: /sbin/reboot, /sbin/tipc-config, /usr/bin/pkill, /usr/bin/killall' >> /etc/sudoers && \
 echo 'Defaults:%opensaf !requiretty' >> /etc/sudoers && \
 echo 'Defaults:opensaf !requiretty' >> /etc/sudoers

RUN mkdir -p /home/opensaf
WORKDIR /home/opensaf

# Add helper build scripts
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/download-opensaf /home/opensaf/download-opensaf
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/configure-opensaf-basic /home/opensaf/configure-opensaf-basic
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/install-opensaf /home/opensaf/install-opensaf

# Add binaries and scripts needing for runtime
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/home/opensaf/setup-opensaf-node /home/opensaf/setup-opensaf-node
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

RUN chmod u+x /home/opensaf/*

# Packages for development. Branch "default" will be build, which is the latest. One can also use opensaf-4.6.x | opensaf-4.5.x | opensaf-4.4.x | opensaf-4.3.x instead.
RUN yum -y install mercurial gcc gcc-c++ libxml2-devel automake m4 autoconf libtool pkg-config make python-devel sqlite-devel && \
    yum clean all && \
    echo "# Build OpenSAF" && \
    cd /home/opensaf && \
    ./download-opensaf && \
    ./configure-opensaf-basic opensaf-4.6.x && \
    ./install-opensaf && \
    rm -rf /home/opensaf/opensaf-* && \
    echo "# Remove development packages" && \
    yum remove -y mercurial gcc gcc-c++ libxml2-devel automake m4 autoconf libtool pkg-config make python-devel sqlite-devel && \
    yum install -y redhat-lsb-core && \ 
    rm -rf /home/opensaf/download-opensaf && \
    rm -rf /home/opensaf/configure-opensaf-basic && \
    rm -rf /home/opensaf/install-opensaf && \
    yum clean all && \
    sed '/\. \/lib\/lsb\/init-functions/ a\\/home\/opensaf\/setup-opensaf-node' -i /etc/init.d/opensafd

ENV container docker

CMD ["/bin/bash"]
