# Caddy Pilot

A custom Caddy server with useful modules pre-installed. Built weekly with the latest Caddy and module versions.

## 🎯 Included Modules

- **[caddy-security](https://github.com/greenpau/caddy-security)** - Authentication, authorization, and accounting
- **[caddy-dns/desec](https://github.com/caddy-dns/desec)** - deSEC DNS provider for ACME DNS challenges

## 🚀 Using This Image

### Quick Start with Docker

```bash
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -p 443:443/udp \
  -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  ghcr.io/ntwritecode/caddy-pilot:latest
```

### Docker Compose Setup

Add this to your `docker-compose.yml`:

```yaml
services:
  caddy:
    image: ghcr.io/ntwritecode/caddy-pilot:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"  # HTTP/3
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
```

Then create your `Caddyfile`:

```caddyfile
example.com {
    reverse_proxy backend:8080
}
```

> **Note:** When reverse proxying to other containers, use the container name (e.g. `backend:8080`), not `localhost`. In Docker, `localhost` means "this container", not "this machine".

Start it:
```bash
docker-compose up -d
```

## 🔧 Forking & Customizing

Want different modules? Fork this repository and customize it:

### 1. Fork the Repository

Click the **Fork** button on GitHub.

### 2. Edit Modules

Update `modules.json` with your desired modules:

```json
{
  "modules": [
    "github.com/caddy-dns/cloudflare",
    "github.com/mholt/caddy-l4",
    "github.com/greenpau/caddy-security"
  ]
}
```

Find modules at:
- [Caddy DNS Providers](https://github.com/orgs/caddy-dns/repositories)
- [Caddy Download Page](https://caddyserver.com/download) (click "Module Documentation")

### 3. Enable GitHub Actions

1. Go to **Settings** > **Actions** > **General**
2. Enable **Read and write permissions**
3. Push your changes or manually trigger the workflow in **Actions** tab

Your custom image will be available at:
```
ghcr.io/your-username/caddy-pilot:latest
```

### 4. Automatic Updates

The workflow runs weekly (Sundays at 3 AM UTC) to rebuild with:
- Latest Caddy version
- Latest module versions
- Multi-architecture support (AMD64 & ARM64)

## 📚 Resources

- [Caddy Documentation](https://caddyserver.com/docs/)
- [Caddy Module Directory](https://caddyserver.com/download)
- [xcaddy - Custom Builder](https://github.com/caddyserver/xcaddy)
- [Caddy Docker Hub](https://hub.docker.com/_/caddy)

## 📝 License

WTFPL - Do What the Fuck You Want to Public License

```
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
```

Caddy and its modules are subject to their respective licenses.

