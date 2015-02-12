FROM adrianszwej/private:rhel6.5-lmstack-prebase 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image ready for adding CBA based components
# Add repos used during building

# Add temporary build repos
ADD etc/yum.repos.b.d/ /etc/yum.repos.d/

# make sure the package repository is up to date
RUN yum -y update

RUN yum -y install lm-stack-v && \
    sed '/\. \/lib\/lsb\/init-functions/ a\\/etc\/init.d\/setup-opensaf-node' -i /etc/init.d/opensafd && \
    yum clean all

RUN cp /etc/tipc-nodes.SCs_PLs /etc/tipc-nodes

RUN rm -f /etc/yum.repos.d/cba-build.repo

CMD ["/bin/bash"]
