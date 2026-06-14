# centos — CentOS Stream 9 Sandbox

A minimal single-VM Vagrant environment running CentOS Stream 9 (ARM64). Used as a scratch box for experimenting with RPM-based Linux tooling.

## VM

| Box | IP | Provider |
|-----|----|----------|
| `shk/centos-stream-9-arm64` | `192.168.56.16` | VMware Desktop |

## Provision

On first boot the VM installs:

```
httpd  wget  unzip  git
```

It also creates `/opt/devopsdir` and prints `free -m` / `uptime` output.

## Usage

```bash
vagrant up
vagrant ssh
```
