FROM caddy:2.11-builder-alpine@sha256:62550826b93ccd464cb510811d8a3b5fa1ccfc56d6e9a008b8f37a404597c951 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:86deaf5e3d3408a6ccec08fbb79989783dd26e206ae10bcf78a801dc8c9ab794

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
