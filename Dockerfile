FROM alpine:3.6

MAINTAINER Dmitry Jerusalimsky <dimaj@dimaj.net>

# Download s6
RUN apk add --no-cache curl\
 && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz \
  | tar xvzf - -C / \
 && apk del --no-cache curl

# if there are any errors during user scripts, terminate
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

COPY rootfs /

# Install nginx and shadow
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/v3.6/community/" >> /etc/apk/repositories && \
    apk add --update nginx shadow bash tzdata && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx


VOLUME /config

EXPOSE 80 443

ENTRYPOINT [ "/init" ]
