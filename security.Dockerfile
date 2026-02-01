FROM caddy:2.11-builder-alpine@sha256:2f97de97992d7508ff5c3c841d8180b240c6f6a166a5d65c70e719866420f3ad AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:cde41549d21e8614840d767dd4cdcdffa8d5fffc312a1c69759fa3163594b2dc

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
