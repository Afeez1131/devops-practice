# fastapi_mvm — FastAPI Multi-VM Deployment

A three-node Vagrant environment that provisions a production-style FastAPI deployment with PostgreSQL, Redis, and Nginx — all fully automated via shell scripts.

## Architecture

```
Host browser
     │
     ▼
 ngx01 (Nginx, :80)  ──proxy──►  FastAPI app (:8000)
                                       │
                          ┌────────────┴────────────┐
                          ▼                         ▼
                    fdb01 (PostgreSQL)         rd01 (Redis)
```

## VMs

| Name | Box | IP | Role |
|------|-----|----|------|
| `fdb01` | `bento/ubuntu-22.04` | `192.168.56.32` | PostgreSQL 14 database |
| `rd01` | `bento/ubuntu-22.04` | `192.168.56.33` | Redis cache |
| `ngx01` | `bento/ubuntu-22.04` | `192.168.56.34` | Nginx + FastAPI app |

## Provisioning Scripts

| Script | What it does |
|--------|-------------|
| `provision_fdb01.sh` | Installs PostgreSQL, opens remote connections for the `192.168.56.0/24` subnet, creates the app user and database |
| `provision_ngx01.sh` | Installs Nginx, clones `Afeez1131/fastapi-demo` from GitHub, creates a Python venv, installs dependencies, writes `.env` with the correct DB/Redis URLs, registers a `systemd` service, and configures Nginx as a reverse proxy |

## Credentials (passed as env vars from Vagrantfile)

```
DB_NAME=demo
DB_USER=afeez1131
DB_PASS=password
```

## Usage

```bash
# Requires vagrant-hostmanager plugin
vagrant plugin install vagrant-hostmanager

vagrant up

# App will be reachable at http://192.168.56.34
```

## Prerequisites

- Vagrant + VMware Desktop
- `vagrant-hostmanager` plugin (manages `/etc/hosts` across VMs)
- Internet access on VM bring-up (clones repo and installs packages)
