FROM caddy:2.11-builder-alpine@sha256:fe361f59fa6340d1e16cc067c0ea10d21fe95dc01dd4f4e87c0e111de069103e AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.11-alpine@sha256:c006ba74d79d94d7464db78a3d2755f6a073c3f65db6da40e35d38e8b5585a33

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
