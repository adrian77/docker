FROM busybox:ubuntu-14.04
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# @Version: 1.0
# The following docker file create static compiled linux kernel with tipc support 
#
RUN mkdir /INBOX
ADD INBOX /INBOX

ENV container docker
WORKDIR /INBOX
ENTRYPOINT /bin/sh
