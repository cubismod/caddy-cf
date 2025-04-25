FROM caddy:2.10-builder-alpine@sha256:16205c8e035dae7faae3cb36ff03d76bb08ae2054968a28cf97ef95d28375e46 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:e2e3a089760c453bc51c4e718342bd7032d6714f15b437db7121bfc2de2654a6

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
