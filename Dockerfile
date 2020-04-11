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

# install consul-template
ENV CONSUL_TEMPLATE_VERSION 0.24.1
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /tmp/consul-template.zip

RUN unzip /tmp/consul-template.zip -d /usr/bin && \
    chmod +x /usr/bin/consul-template && \
    rm /tmp/consul-template.zip


EXPOSE 80 443

ENTRYPOINT [ "/init" ]
