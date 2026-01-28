FROM caddy:2.11-builder-alpine@sha256:9f428efe28d2cfd5dc52d3371a5c8cfa5e17d83d067fe49cd003c88e324bcbd3 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:8f2f33e163ae1fc4f83c6f718b31d5e475ea31ef8f1991bb7a41836203dd795e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
