FROM caddy:2.11-builder-alpine@sha256:6f6b45723b2a927d17e3473a16512b4ed8cdce6d432a4a3aa5fecc130466e81b AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:195776f0132302e6cebc592da06be51386d291db7f82e70caf954b564439c33b

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
