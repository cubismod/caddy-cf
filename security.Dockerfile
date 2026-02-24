FROM caddy:2.11-builder-alpine@sha256:f84f4ef330a499d39b1a7a48355a0f795e75f01abc3d86238fdbd55a969abbea AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:b68d7750515c12d3b74b826b9375c5df0d4512891cdef6c10f588ac02b5a1d5e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
