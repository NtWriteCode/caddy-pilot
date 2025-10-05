FROM caddy:builder AS builder

# Copy the modules configuration
COPY modules.json /tmp/modules.json

# Build Caddy with custom modules
RUN xcaddy build \
    $(jq -r '.modules | map("--with " + .) | join(" ")' /tmp/modules.json)

# Final stage: use the official Caddy image as base
FROM caddy:latest

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Copy Caddyfile (if exists)
COPY Caddyfile /etc/caddy/Caddyfile

# Expose ports
EXPOSE 80 443 2019

# Use the standard Caddy entrypoint
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

