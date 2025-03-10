ARG S6_OVERLAY_VERSION=v3.2.0.0
FROM socheatsok78/s6-overlay-distribution:${S6_OVERLAY_VERSION} AS s6-overlay

FROM nginx:stable-alpine
COPY --link --from=s6-overlay / /

RUN apk add --no-cache \
    bash \
    cgit \
    fcgiwrap \
    git \
    git-daemon \
    groff \
    highlight \
    lua5.3-libs \
    perl \
    perl-cgi \
    py3-markdown \
    py3-pygments \
    py3-docutils \
    spawn-fcgi \
    tzdata \
    xz \
    zlib

# Create git user and install gitolite
RUN <<EOF
    mkdir -p /var/lib/git
    addgroup -S git
    adduser -S -D -G git -h /var/lib/git git
EOF
USER git
ADD https://github.com/sitaramc/gitolite.git /var/lib/git/gitolite
RUN <<EOF
    cd /var/lib/git
    mkdir -p /var/lib/git/bin
    gitolite/install -to /var/lib/git/bin
EOF

# Switch back to root user
ADD rootfs /
ENTRYPOINT [ "/init-shim", "/docker-entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
STOPSIGNAL SIGQUIT

USER root
VOLUME [ "/data", "/var/cache/cgit" ]
WORKDIR /data

EXPOSE 9418/tcp 9418/udp
