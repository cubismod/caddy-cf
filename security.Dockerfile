FROM caddy:2.11-builder-alpine@sha256:b6a94e74b72261bd536b35acdd22f3577d4e466a9550f2c8d6c8ed6413085d72 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:5f5c8640aae01df9654968d946d8f1a56c497f1dd5c5cda4cf95ab7c14d58648

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
