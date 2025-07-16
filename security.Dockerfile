FROM caddy:2.10-builder-alpine@sha256:381e747dd0ed350dfff6154ebc54e30f568040b03ec494616cbc21ef4645ba84 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:55ce1e7720af63164b96a8181cbf11dd64ea1bf1639852c5b5213344a5b204ae

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
