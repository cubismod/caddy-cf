FROM caddy:2.11-builder-alpine@sha256:ee0ed9b61c73edd1c2db10a8b7cd004edfb338b45ea9cf7f0bc5e137c578b582 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:b78e09965e218a19e7a04be078c7fc3203d520264efee080a9ea312e2c639d89

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
