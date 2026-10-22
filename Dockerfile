FROM caddy:2.11.7-builder-alpine@sha256:bb53bc0dd94d5e93eca88bac50e435fd5f9dc6cc828fc6140086f282fb329e92 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/cache-handler \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/darkweak/storages/nuts/caddy \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:2.11.7-alpine@sha256:24ec7b05bc532c7bb57f727030c5056e257ff7138b4b50460306819ff79362bd

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir /nuts && chmod 700 /nuts

LABEL maintainer="Ryan Wallace <git@hexa.mozmail.com>"
