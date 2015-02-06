FROM richxsl/rhel6.5:latest 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image ready for adding CBA based components

# Add repos used during building 
ADD etc/yum.repos.b.d/* /etc/yum.repos.d/

# make sure the package repository is up to date
RUN yum -y update

# Packages for usuability
RUN yum -y install tar && yum clean all

# Packages needed for OpenSAF runtime 
RUN yum -y install net-tools sqlite3 libxml2 redhat-lsb-core && \
    yum clean all

# Install python 2.7
RUN yum install -y python27

# Make sure python 2.7 is used for root account
ADD root/.bashrc /root/.bashrc
ADD extra-sw/PyYAML-3.11.tar /tmp

RUN ls -la /tmp

RUN cd /tmp/PyYAML-3.11 && \
    source /root/.bashrc && \
    yum install -y libyaml && \
    python setup.py install && \
    python --version && \
    rm -rf /tmp/PyYAML-3.11

# Install 32 Libraries needed by license manager component
RUN yum install -y libstdc++.i686 zlib.i686 libcrypto-0.9.8.i686 libcrypto-0.9.8 csh

# Remove the repos used during build
RUN rm -rf /etc/yum.repos.d/*

# Add repos that will be linked with a ftp container serving the repos
ADD etc/yum.repos.d/* /etc/yum.repos.d/

# Pass configuration for utility scripts
ENV container docker

CMD ["/bin/bash"]
