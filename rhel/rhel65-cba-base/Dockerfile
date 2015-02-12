FROM adrianszwej/private:rhel6.5-base 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Base image ready for adding CBA based components using external yum repository

# Add repos used during building 
ADD etc/yum.repos.b.d/* /etc/yum.repos.d/

# make sure the package repository is up to date
RUN yum -y update

# Packages for usuability
RUN yum -y install tar && yum clean all

# Remove the repos used during build
RUN rm -rf /etc/yum.repos.d/*

# Add repos that will be linked with a ftp container serving the repos
ADD etc/yum.repos.d/* /etc/yum.repos.d/

CMD ["/bin/bash"]
