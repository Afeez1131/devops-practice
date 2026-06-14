# DevOps Practice Lab

A collection of hands-on DevOps exercises covering Vagrant, shell scripting, Docker, multi-VM networking, Infrastructure as Code, and CI/CD pipelines.

All environments run on **VMware Desktop** and target **Apple Silicon (ARM64)** unless otherwise noted.

---

## Projects

### Vagrant & Linux Fundamentals

| Folder | Description |
|--------|-------------|
| [ubuntu](./ubuntu/README.md) | Ubuntu ARM sandbox with Apache2 and a synced scripts folder |
| [centos](./centos/README.md) | CentOS Stream 9 scratch box with HTTPD, wget, git |
| [fedora](./fedora/README.md) | Fedora 40 bare VM for exploring DNF |

### Multi-VM Networking

| Folder | Description |
|--------|-------------|
| [multivm](./multivm/README.md) | Three-node lab (2× Ubuntu web + 1× CentOS MariaDB) to practise multi-machine Vagrantfiles and private networking |
| [BashScripts](./BashScripts/README.md) | Three-node environment (scriptbox + web + db) for shell scripting practice across mixed distros |

### Infrastructure as Code (IAC)

| Folder | Description |
|--------|-------------|
| [finance](./finance/README.md) | Mini Finance website served via Apache — manual provisioning version |
| [financeIAC](./financeIAC/README.md) | Same Finance website, fully declared in a reproducible Vagrantfile (IAC) |
| [wordpress](./wordpress/README.md) | Full WordPress stack (Apache + PHP + MySQL) — manual provisioning |
| [wordpressIAC](./wordpressIAC/README.md) | Same WordPress stack, written as idempotent IAC |

### Containers

| Folder | Description |
|--------|-------------|
| [containerIntro](./containerIntro/README.md) | Ubuntu VM that auto-installs Docker + Compose; includes a multi-service e-commerce compose stack (Nginx, Angular, Node, Java, MongoDB, MySQL) |

### Multi-Tier Application Deployments

| Folder | Description |
|--------|-------------|
| [fastapi_mvm](./fastapi_mvm/README.md) | Three-VM FastAPI deployment: PostgreSQL (fdb01) + Redis (rd01) + Nginx/FastAPI (ngx01), fully automated with provision scripts |
| [vprofile-project](./vprofile-project/README.md) | Spring MVC Java app with Vagrant multi-VM provisioning (manual & automated), Ansible playbooks, and a Jenkins CI/CD pipeline (Build → Test → SonarQube → Nexus) |

### AWS / Cloud

| Folder | Description |
|--------|-------------|
| [ALB](./ALB/README.md) | Load-test script for an AWS Application Load Balancer — sends concurrent requests and reports RPS vs. auto-scaling threshold |

---

## Common Commands

```bash
# Start a project
cd <folder>
vagrant up

# SSH into the VM
vagrant ssh

# SSH into a specific VM in a multi-machine setup
vagrant ssh <vm-name>

# Stop all VMs in a project
vagrant halt

# Destroy and rebuild from scratch
vagrant destroy -f && vagrant up
```

## Prerequisites

- [Vagrant](https://www.vagrantup.com/) ≥ 2.3
- [VMware Desktop](https://www.vmware.com/products/desktop-hypervisor.html) + Vagrant VMware plugin
- `vagrant-hostmanager` plugin (required for `fastapi_mvm`)

```bash
vagrant plugin install vagrant-vmware-desktop
vagrant plugin install vagrant-hostmanager
```
