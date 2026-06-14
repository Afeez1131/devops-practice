# containerIntro — Docker Introduction Lab

A Vagrant-based environment that automatically installs Docker inside an Ubuntu VM, with a `docker-compose.yaml` that models a realistic multi-service e-commerce application.

## Files

| File | Description |
|------|-------------|
| `Vagrantfile` | Spins up Ubuntu 22.04 and runs `docker.sh` on provision |
| `docker.sh` | Installs Docker Engine + Compose plugin and adds the `vagrant` user to the `docker` group |
| `docker-compose.yaml` | Multi-container e-commerce app stack |

## Application Stack (docker-compose)

| Service | Image / Build | Port | Description |
|---------|--------------|------|-------------|
| `nginx` | `nginx:latest` | 80 | Reverse proxy / entry point |
| `client` | `./client` | 4200 | Angular frontend |
| `api` | `./nodeapi` | 5000 | Node.js REST API (MongoDB) |
| `webapi` | `./javaapi` | 9000 | Java REST API (MySQL) |
| `emongo` | `mongo:4` | 27017 | MongoDB for the Node API |
| `emartdb` | `mysql:8.0.33` | 3306 | MySQL for the Java API |

## Usage

```bash
# 1. Boot the VM (Docker is installed automatically)
vagrant up

# 2. SSH in
vagrant ssh

# 3. Navigate to the shared folder and bring up the stack
cd /vagrant
docker compose up -d

# 4. Visit the app
# http://192.168.33.10  (or whatever IP is configured)
```

## Prerequisites

- Vagrant + VMware Desktop
- The `client`, `nodeapi`, and `javaapi` build contexts must be present alongside the compose file if you intend to build from source.
