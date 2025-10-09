FROM caddy:2.10-builder-alpine@sha256:a2bd1100fec0276f96598a4f46efecd4f2a822d5cec66c3a8f9384c7fe32c91d AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:f878dac093277bc6d5ac2baf3068664e4645905da770135b904b25ca85c7707e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
