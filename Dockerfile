FROM alpine:3.11

MAINTAINER Dmitry Jerusalimsky <dimaj@dimaj.net>

# Download s6
RUN apk add --no-cache curl\
 && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz \
  | tar xvzf - -C / \
 && apk del --no-cache curl

# if there are any errors during user scripts, terminate
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# Install nginx and shadow
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.11/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/v3.11/community/" >> /etc/apk/repositories && \
    apk add --update nginx gettext bash shadow tzdata shadow && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx

# remove default website
RUN rm /etc/nginx/conf.d/default.conf

# install consul-template
ENV CONSUL_TEMPLATE_VERSION 0.24.1

RUN apk add --no-cache curl &&\
    curl https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip --output /tmp/consul-template.zip && \
    unzip /tmp/consul-template.zip -d /usr/bin && \
    chmod +x /usr/bin/consul-template && \
    rm /tmp/consul-template.zip && \
    apk del --no-cache curl

ENV CONSUL_URL=localhost:8500
COPY rootfs /

EXPOSE 80 443

ENTRYPOINT [ "/init" ]
