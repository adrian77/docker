FROM alpine:latest
RUN apk update && \
    apk add openssh-client && \
    apk add screen 
ADD to-add /
#RUN adduser -s /bin/sh -D user 
#RUN chown -R user:user /B
WORKDIR /B
CMD /B/run
