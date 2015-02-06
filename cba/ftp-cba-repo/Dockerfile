FROM ubuntu:14.04 
MAINTAINER Adrian Szwej <adrian.szwej@ericsson.com>
# @Version: 1.0
# Image containing CBA repository with CoreMW & LM 
RUN apt-get -y update

# Install the ftp server
RUN apt-get -y install vsftpd

RUN sed -i 's/local_enable=no/local_enable=NO/g' /etc/vsftpd.conf && \
    sed -i 's/anonymous_enable=NO/anonymous_enable=YES/g' /etc/vsftpd.conf && \
    sed -i '/anonymous_enable=YES/ianon_root=\/yum-repos' /etc/vsftpd.conf && \
    sed -i '/anonymous_enable=YES/iseccomp_sandbox=NO' /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty

# The directory that will be exposed by the server
VOLUME /yum-repos

EXPOSE 21 

ENV container docker

CMD ["/usr/sbin/vsftpd"]
