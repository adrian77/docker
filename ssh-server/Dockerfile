FROM ubuntu:17.04

EXPOSE 22
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean all
ADD to-add /
RUN useradd -m -s /bin/rbash 1024
RUN useradd -m -s /bin/rbash 1025
RUN useradd -m -s /bin/rbash 1026
RUN useradd -m -s /bin/rbash 1027
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /run/sshd

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
