FROM caddy:2.11-builder-alpine@sha256:308108f69cc5f95ae06922439c6d1b8c5c244030cf3d7c9df483b5b92d2e5932 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:da9e5fd32863242387e34dd330427b739564771fd602ca6a435c92e92f97172d

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
