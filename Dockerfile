FROM caddy:2.11.4-builder-alpine@sha256:ab1676a9f2ccdb1ca0a1cd565ba2ff9590967c587506aa33bb66e2c9befa22f5 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/darkweak/storages/nuts/caddy \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:2.11.4-alpine@sha256:251145d731269e9051fd2012e2243eb24b12ef98de4d5a84c27709cb2a17ce3c

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir /nuts && chmod 700 /nuts

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
