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

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
