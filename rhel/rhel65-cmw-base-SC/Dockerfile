FROM adrianszwej/private:rhel6.5-cmw-prebase 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image with packages installed in order to install and run CoreMW. 

#Add repos used during building 
ADD etc/yum.repos.b.d/ /etc/yum.repos.d/

# make sure the package repository is up to date
RUN yum -y clean all && \
    yum -y update

# Packages needed for coremw runtime 
RUN yum -y install COREMW_SC-v && \
    sed '/\. \/lib\/lsb\/init-functions/ a\\/etc\/init.d\/setup-opensaf-node' -i /etc/init.d/opensafd && \
    yum clean all

# Make sure python 2.7 is used for root account
ADD root/.bashrc /root/.bashrc

ADD extra-sw/PyYAML-3.11.tar /tmp

RUN cd /tmp/PyYAML-3.11 && \
    source /root/.bashrc && \
    yum install -y libyaml && \
    python setup.py install && \
    rm -rf /tmp/PyYAML-3.11

# Stuff for the cmwea
RUN cp /etc/tipc-nodes.SCs_PLs /etc/tipc-nodes

# Remove the build repo
RUN rm -f /etc/yum.repos.d/cba-build.repo

CMD ["/bin/bash"]

#/etc/init.d/start-coremw
