*This project has been created as part of the 42 curriculum by lmokhtar.*

---

## Description

**Inception** is a 42 system administration project. The goal is to set up a small infrastructure using Docker Compose, running inside a virtual machine. All images are built from scratch (`debian:bullseye`) — no pre-built Docker Hub images allowed.

The stack contains three services:

| Container | Role |
|---|---|
| **NGINX** | Reverse proxy, sole entrypoint — HTTPS only (TLS 1.2/1.3) |
| **WordPress** | PHP-FPM app server (WordPress 6.9) |
| **MariaDB** | Database backend |

### Design choices

- **One process per container** via `ENTRYPOINT`.
- **Named volumes** (bind-mounted to `/home/lmokhtar/data/`) for data persistence across rebuilds.
- **Bridge network** (`inception`) for isolated inter-container communication; only port 443 is published.
- **`.env` file** for injecting credentials at runtime — nothing hard-coded in images.
- **Self-signed TLS certificate** generated at build time by OpenSSL inside the NGINX image.

### Virtual Machines vs Docker

| VMs | Docker |
|---|---|
| Full OS per VM, GBs of overhead | Shares host kernel, MBs of overhead |
| Hardware-level isolation (hypervisor) | Process isolation (namespaces + cgroups) |
| Minutes to boot | Sub-second startup |

Docker is used here because the goal is to isolate services, not full OS environments.

### Secrets vs Environment Variables

| Environment Variables | Secrets |
|---|---|
| Plaintext in `.env` or shell | Encrypted, mounted as read-only files |
| Visible to all container processes | Access-controlled |
| Fine for school/dev environments | Required in production |

This project uses `.env` for simplicity. Production workloads should use Docker secrets or a secrets manager.

### Docker Network vs Host Network

| Bridge Network | Host Network |
|---|---|
| Own network namespace per container | Shares host network stack |
| DNS by container name | No isolation from host |
| Explicit port mapping | All ports exposed immediately |

A `bridge` network lets WordPress reach `mariadb:3306` by name while keeping everything isolated except port 443.

### Docker Volumes vs Bind Mounts

| Docker Volumes | Bind Mounts |
|---|---|
| Managed by Docker, portable | Tied to a specific host path |
| Harder to browse directly | Easy to inspect from the host |

This project uses named volumes with bind-mount driver options — Docker manages the lifecycle, data lives at `/home/lmokhtar/data/` and is directly accessible on the host.

---

## Instructions

**Prerequisites**: Docker, Docker Compose, and `make` installed on a Linux machine.

```bash
git clone <repository-url> inception && cd inception
make        # creates data dirs, builds images, starts containers
```

The site is available at `https://lmokhtar.42.fr` once all containers are up.

| Target | Action |
|---|---|
| `make logs` | Print container logs |
| `make clean` | Stop containers and remove network |
| `make fclean` | `clean` + wipe data + prune all Docker objects |
| `make re` | Full rebuild (`fclean` + `all`) |

> **Warning**: `make fclean` permanently deletes all persisted data.

---

## Resources

- [Docker docs](https://docs.docker.com/) · [Docker Compose](https://docs.docker.com/compose/compose-file/) · [Dockerfile best practices](https://docs.docker.com/develop/develop-images/instructions/)
- [NGINX docs](https://nginx.org/en/docs/) · [MariaDB KB](https://mariadb.com/kb/en/) · [WordPress dev](https://developer.wordpress.org/) · [WP-CLI](https://wp-cli.org/)
- [PHP-FPM config](https://www.php.net/manual/en/install.fpm.configuration.php) · [OpenSSL req](https://www.openssl.org/docs/manmaster/man1/openssl-req.html)
- [VMs vs Containers (IBM)](https://www.ibm.com/think/topics/containers-vs-vms) · [Docker secrets vs env vars](https://blog.gitguardian.com/how-to-handle-secrets-in-docker/)

### AI usage

GitHub Copilot was used for: writing this README, debugging Dockerfile build errors, and reviewing the NGINX/PHP-FPM configuration. All suggestions were reviewed and adapted manually.
