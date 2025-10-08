FROM caddy:2.10-builder-alpine@sha256:d314c56dec50dbddd6abf6ba7d8a3093705c2c23a26940a3525747924cc26022 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:a4180db0805b3725ddf936d2e6290553745c7339c003565da717ee612fd8a888

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
