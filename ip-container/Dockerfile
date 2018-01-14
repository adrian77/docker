FROM ubuntu:17.04
LABEL template.version="1.0"
LABEL maintainer.name="Adrian Szwej"
LABEL maintainer.email="adrian.szwej@gmail.com"
LABEL docker.version="17.09"

WORKDIR /
ENTRYPOINT ["/entry.sh"]
#EXPOSE
#VOLUME

RUN apt-get update && apt-get install -y \
    vim \
    less \
    && /bin/true 

RUN useradd --create-home --shell /bin/bash --password '$6$YF6XtJeC$YzHs4fApOJxRfvTyD4HagkvVufu4yluRvDvcE0kx7S.3cst/MMdT2P15MJnSpJ17ZoN.6SBdig.pt8XpDkdAJ/' ubuntu

ADD to-add /
#ENV A 1.0
#CMD ["/bin/bash"]
