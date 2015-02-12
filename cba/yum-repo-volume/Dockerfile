FROM scratch 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Image containing yum database as volume 

# The directory that will be exposed by the server
VOLUME /yum-repos/cba-repo
COPY true-asm /true

ADD repo /yum-repos/cba-repo/

ENV container docker

CMD ["/true"]
