FROM caddy:2.11.2-builder-alpine@sha256:1e770e28d9fe30cc199850a038d5046b942b87d1a17fc07f2f7117aef5e7d23c AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list

FROM caddy:2.11.2-alpine@sha256:da4a361525d2beafe72351888897e63fa10b1462bb9b58145e21e601c876bd86

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
