FROM ubuntu:15.04
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.2
# The following docker file perform E2E development setup to OpenSAF installation 
#   Moments contain download development packages; download OpenSAF source code; compile; install and finally remove the development packages and the build result
#
# How to run container from this image:
# NODE=SC-1 && docker run --privileged -t --name $NODE -h $NODE -v /home/adrian/sharedfs:/etc/opensaf/sharedfs -i <img-id> 
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

RUN chmod u+x /home/opensaf/* && \
    chmod u+x /sbin/tipc-config

# make sure the package repository is up to date
RUN apt-get update


# Packages needed for for runtime. Python is only used for generation of initial xml; but also for cluster resize.
RUN apt-get install -y sudo sqlite3 libxml2 psmisc python net-tools kmod && \
    apt-get clean  

RUN install OPENSAF RPMs
ENV container docker

CMD    ["/bin/bash"]
