FROM caddy:2.10-builder-alpine@sha256:2cf9b153f9f65bc7dbaef420968aee70bc0c9e570b2c217777014e1c329de416 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:64642fe1e2319c999d20aa489a73e261b5b4ae4fab29385b61e5221287af5c42

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
