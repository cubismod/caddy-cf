FROM caddy:2.6-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.6-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
