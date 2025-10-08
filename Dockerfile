FROM caddy:2-builder AS builder

# Copy the modules configuration
COPY modules.txt /tmp/modules.txt

# Build Caddy with custom modules using cache mounts for faster builds
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    $(awk '{printf "--with %s ", $0}' /tmp/modules.txt)

# Final stage: use the official Caddy image as base
FROM caddy:2

RUN mkdir -p /usr/share/GeoIP && wget https://github.com/P3TERX/GeoLite.mmdb/releases/latest/download/GeoLite2-Country.mmdb -O /usr/share/GeoIP/GeoLite2-Country.mmdb

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
