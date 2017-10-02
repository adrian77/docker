FROM ubuntu:16.04

LABEL maintainer.name="Adrian Szwej"
LABEL maintainer.mail="adrian.szwej@gmail.com"
LABEL image.description="Image containing opensaf middleware with basic services"
LABEL container.run="NODE=SC-1 && docker run -t --name \$NODE -h \$NODE -v /home/adrian/sharedfs:/etc/opensaf/sharedfs -i <img>"

RUN mkdir -p /home/opensaf
WORKDIR /home/opensaf

# Add binaries and scripts needing for runtime
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/home/opensaf/setup-opensaf-node /etc/init.d/setup-opensaf-node
ADD https://raw.githubusercontent.com/adrian77/docker/master/opensaf/scripts/for-running/sbin/tipc-config /sbin/tipc-config

RUN chmod u+x /sbin/tipc-config \
    && chmod u+x /etc/init.d/setup-opensaf-node

# Packages needed for for runtime. Python is only used for generation of initial xml; but also for cluster resize.
RUN apt-get update && apt-get install -y \
    sudo \
    sqlite3 \ 
    libxml2 \
    psmisc \
    python2.7-minimal \ 
    net-tools \ 
    kmod \
    && apt-get autoremove -y \
    && apt-get clean \ 
    && rm /var/lib/apt/lists/*.lz4

# Dynamic part which can be sent via --build-arg version=5.2.GA
ARG buildversion="5.2.GA"
ARG configureflags="--enable-imm-pbe --disable-ais-plm --disable-ais-msg --disable-ais-lck --disable-ais-evt --disable-ais-ckpt --enable-tipc"

# Packages for development. Branch "default" will be build, which is the latest. One can also use opensaf-4.6.x | opensaf-4.5.x | opensaf-4.4.x | opensaf-4.3.x instead. 
RUN apt-get update && apt-get install -y \
    mercurial gcc g++ libxml2-dev automake m4 autoconf libtool pkg-config make python-dev libsqlite3-dev binutils \
    && cd /home/opensaf \
    && hg clone http://hg.code.sf.net/p/opensaf/staging opensaf-staging \
    && cd opensaf-* \
    && hg update $buildversion \
    && ./bootstrap.sh \
    && ./configure $configureflags \
    && make install \
    && ldconfig \
    && sed '/\. \/lib\/lsb\/init-functions/ a\\/etc\/init.d\/setup-opensaf-node' -i /etc/init.d/opensafd \
    && rm -rf /home/opensaf/opensaf-* \
    && rm -rf /home/opensaf/download-opensaf \
    && rm -rf /home/opensaf/configure-opensaf-basic \
    && rm -rf /home/opensaf/install-opensaf \
    && rm -rf /usr/share/doc \
    && rm -rf /usr/share/man  \
    && strip /usr/local/lib/opensaf/* \
    || apt-get remove -y \
    mercurial gcc g++ libxml2-dev automake m4 autoconf libtool pkg-config make python-dev libsqlite3-dev binutils \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm /var/lib/apt/lists/*.lz4

RUN groupadd opensaf && \
 useradd -r -g opensaf -d /var/run/opensaf -s /sbin/nologin -c "OpenSAF" opensaf && \
 echo '%{opensaf_user} ALL = NOPASSWD: /sbin/reboot, /sbin/tipc-config, /usr/bin/pkill, /usr/bin/killall' >> /etc/sudoers && \
 echo 'Defaults:%opensaf !requiretty' >> /etc/sudoers && \
 echo 'Defaults:opensaf !requiretty' >> /etc/sudoers

ENV container docker

CMD ["/bin/bash"]
