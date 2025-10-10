FROM caddy:2.10-builder-alpine@sha256:dbf2f10a5eb99f7ae6d35e2dc533091a221a8b9b4eb10fc83b3f5bab49067337 AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/greenpau/caddy-security

FROM caddy:2.10-alpine@sha256:7d75b1294f73048155757377c38f05621a65c8df4f261077aa3091c9168ea53a

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"

CMD ["caddy", "docker-proxy"]
