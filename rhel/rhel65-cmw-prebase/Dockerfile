FROM adrianszwej/private:rhel6.5-cba-base 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image with packages installed in order to install and run CoreMW. 

# Add repos used during building 
ADD etc/yum.repos.b.d/ /etc/yum.repos.d/
ADD etc/init.d/* /etc/init.d/
#ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

# make sure the package repository is up to date
RUN yum -y update

# Packages needed for coremw runtime 
RUN yum -y install net-tools sqlite3 libxml2 redhat-lsb-core && \
    yum clean all

RUN rm -f /etc/yum.repos.d/cba-build.repo

CMD ["/bin/bash"]
