FROM caddy:2.11-builder-alpine@sha256:17a6e602fb6d9cae776ea0ae344a499273707c423fa0f86457ef928a95b6a83e AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:4c70004f2961afb5fcb76b770967593855cdc10a8ff228125d58ba4eb014701c

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
