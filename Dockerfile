FROM caddy:2.10.2-builder-alpine@sha256:a2bd1100fec0276f96598a4f46efecd4f2a822d5cec66c3a8f9384c7fe32c91d AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list

FROM caddy:2.10.2-alpine@sha256:f878dac093277bc6d5ac2baf3068664e4645905da770135b904b25ca85c7707e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
