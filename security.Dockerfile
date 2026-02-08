FROM caddy:2.11-builder-alpine@sha256:f8d3783ef1c0388cba6295a72ecc8dd513435bd9f399d38467d7e068b0f6f13b AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:cde41549d21e8614840d767dd4cdcdffa8d5fffc312a1c69759fa3163594b2dc

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
