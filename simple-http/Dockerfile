FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y python && \
    apt-get clean all
CMD cd /www-data && python -m SimpleHTTPServer 80
