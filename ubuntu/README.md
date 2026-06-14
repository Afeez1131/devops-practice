# ubuntu — Ubuntu ARM Sandbox

A single Ubuntu ARM VM with Apache2 pre-installed. The host's `~/Desktop/scripts` directory is synced into `/opt/scripts` inside the VM, making it easy to run local scripts against a live Linux environment.

## VM

| Box | IP | RAM | CPUs |
|-----|----|-----|------|
| `spox/ubuntu-arm` `1.0.0` | `192.168.210.14` | 1600 MB | 2 |

## Synced Folder

| Host path | Guest path |
|-----------|-----------|
| `/Users/mac/Desktop/scripts` | `/opt/scripts` |

## Provision

```bash
apt-get install -y apache2
```

`free -m` and `date` are also printed on first boot for a quick sanity check.

## Usage

```bash
vagrant up
vagrant ssh

# Scripts on your Desktop are immediately available:
ls /opt/scripts
```
