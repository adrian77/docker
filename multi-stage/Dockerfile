FROM ubuntu:17.04
LABEL template.version="1.0"
LABEL maintainer.name="Adrian Szwej"
LABEL maintainer.eamil="adrian.szwej@gmail.com"
LABEL docker.version="17.09"

WORKDIR /
ENTRYPOINT ["/entry.sh"]
#EXPOSE
#VOLUME

RUN apt-get update && apt-get install -y \
    vim \
    less \
    && /bin/true 

ADD to-add /
#ENV A 1.0
#CMD ["/bin/bash"]

FROM alpine:latest
