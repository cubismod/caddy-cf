FROM caddy:2.11.4-builder-alpine@sha256:0ff10d4b83af453e5526b1c3cd7ae43396832aa8a2a55311d624f6812b33767d AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/darkweak/storages/nuts/caddy \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:2.11.4-alpine@sha256:77c07d5ebfa5be9fd6c820d2094ae662c9e7eeb9bf98346b7f639900263ee2a2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir /nuts && chmod 700 /nuts

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
