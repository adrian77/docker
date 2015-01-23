FROM fedora:21
MAINTAINER “Adrian Szwej” <adrian.szwej@gmail.com>
ENV container docker

#RUN yum -y update
RUN yum -y install systemd rsyslog openssh-server; yum clean all

# Generate the SSH keys
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# Enable needed services
RUN systemctl enable sshd.service
RUN systemctl enable rsyslog.service

# To access ssh
RUN echo 'root:password' | chpasswd

# Needed for systemd
VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 22

CMD ["/usr/sbin/init"]
