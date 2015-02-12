FROM adrianszwej/private:rhel6.5-cmw-prebase 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image for lmstack POC

# Add temporary build repos
ADD etc/yum.repos.b.d/ /etc/yum.repos.d/

# make sure the package repository is up to date
RUN yum -y update

# Install python 2.7
RUN yum install -y python27

# Make sure python 2.7 is used for root account
ADD root/.bashrc /root/.bashrc

ADD extra-sw/PyYAML-3.11.tar /tmp

RUN cd /tmp/PyYAML-3.11 && \
    source /root/.bashrc && \
    yum install -y libyaml && \
    python setup.py install && \
    rm -rf /tmp/PyYAML-3.11

# Install 32 Libraries needed by license manager component
RUN yum install -y libstdc++.i686 zlib.i686 libcrypto-0.9.8.i686 libcrypto-0.9.8 csh

RUN rm -f /etc/yum.repos.d/cba-build.repo

CMD ["/bin/bash"]
