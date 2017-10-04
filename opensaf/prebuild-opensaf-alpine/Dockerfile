FROM alpine:latest
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.3
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
# Shared fs if you have two controllers. The setup-opensaf-node will check for this dir and use that instead.
# Additional use -v /home/adrian/sharedfs:/etc/opensaf/sharedfs and then configure IMM PBE to use this directory persisting IMM data
#

RUN mkdir -p /home/opensaf
WORKDIR /home/opensaf

# Add helper build scripts 
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/download-opensaf /home/opensaf/download-opensaf
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/configure-opensaf-basic /home/opensaf/configure-opensaf-basic
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-building/home/opensaf/install-opensaf /home/opensaf/install-opensaf

# Add binaries and scripts needing for runtime
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/home/opensaf/setup-opensaf-node /home/opensaf/setup-opensaf-node
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

RUN chmod u+x /home/opensaf/* && \
    chmod u+x /sbin/tipc-config

# Packages needed for for runtime. Python is only used for generation of initial xml; but also for cluster resize.
RUN apk update && apk add \
    sudo \
    sqlite-libs \ 
    libxml2 \
    psmisc \
    python2 \ 
    net-tools \ 
    kmod 

ENV container docker

CMD ["/bin/bash"]
