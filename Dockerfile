FROM caddy:2.11.3-builder-alpine@sha256:7d2315853f99b425d0daa6bcad826e8b0d65b4af1f70fcaeb6b152157d81771d AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/darkweak/storages/nuts/caddy

FROM caddy:2.11.3-alpine@sha256:bb56e6200ec26a67f04be90255993dc390c9815967f67f24b4ca6466e88de64b

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir /nuts && chmod 700 /nuts

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
