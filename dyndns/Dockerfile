FROM ubuntu:18.04
LABEL template.version="1.0"
LABEL maintainer.name="Adrian Szwej"
LABEL maintainer.email="adrian.szwej@gmail.com"
LABEL docker.version="17.09"

WORKDIR /
ENTRYPOINT ["/entry.sh"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ddclient \
    && /bin/true 

ADD to-add /
#ENV A 1.0
CMD ["/config/etc/ddclient.conf"]
