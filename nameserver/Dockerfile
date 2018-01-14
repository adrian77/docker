FROM ubuntu:17.04
LABEL template.version="1.0"
LABEL maintainer.name="Adrian Szwej"
LABEL maintainer.email="adrian.szwej@gmail.com"
LABEL docker.version="17.09"

WORKDIR /
ENTRYPOINT ["/entry.sh"]

RUN apt-get update && apt-get install -y \
    bind9 \
    rsyslog \
    && /bin/true 

ADD to-add /

RUN mkdir /var/log/named \
    && chown -R root:bind /var/log/named/ \
    && chmod g+w /var/log/named
#CMD ["/bin/bash"]
