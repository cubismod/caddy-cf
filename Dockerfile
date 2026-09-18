FROM caddy:2.11.4-builder-alpine@sha256:2b9f32cbba6045e79212bb253f595588d20be8f7d1edf61582c519e124e0d2d8 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/darkweak/storages/nuts/caddy \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:2.11.4-alpine@sha256:de23def33b17fb5d1290b0f6c2add1d70780e52341896c00a4c8a2a2fe9d355e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir /nuts && chmod 700 /nuts

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
