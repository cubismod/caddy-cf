FROM caddy:2.11-builder-alpine@sha256:97b0e2504f8a28a9c8a62f509a8f1138102d2ddd5e7708b9b6ba0a3e6e6ec9db AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:224f38ecbc1996eb5c70d8c1c1aa28ea6821371278a0e971993d315e036ed734

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
