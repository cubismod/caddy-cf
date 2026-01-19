FROM caddy:2.11-builder-alpine@sha256:ee0ed9b61c73edd1c2db10a8b7cd004edfb338b45ea9cf7f0bc5e137c578b582 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:14fa514e8fe24ab9fe4ad7424eb83cc1a230ae4342a0e3ad8b1d44873f5fc472

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
