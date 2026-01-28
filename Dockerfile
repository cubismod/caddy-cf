FROM caddy:2.10.2-builder-alpine@sha256:5767b29a8e70989e8c014d0f2e3c2d2ced57f53709ca2f916485788eecfb2e27 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list

FROM caddy:2.10.2-alpine@sha256:d20ae4dc75c930dc23b12c3659de457fb2a15f5ac1fcf8cb8d5b7bf5f330e223

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
