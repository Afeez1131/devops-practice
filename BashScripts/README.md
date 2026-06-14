# BashScripts — Multi-VM Scripting Lab

A three-node Vagrant environment used to practise shell scripting across mixed Linux distributions. The setup runs on VMware Desktop.

## VMs

| Name | Box | IP | Role |
|------|-----|----|------|
| `scriptbox` | `bento/ubuntu-22.04` | `192.168.56.40` | Script execution box |
| `web02` | `bento/ubuntu-22.04` | `192.168.56.42` | Web node |
| `db01` | `shk/centos-stream-9-arm64` | `192.168.56.46` | Database node (CentOS) |

## Usage

```bash
# Start all VMs
vagrant up

# SSH into the script box
vagrant ssh scriptbox

# Stop all VMs
vagrant halt
```

## Notes

- All VMs have both a private network and a bridged public network interface.
- `scriptbox` is the control node — run your scripts from here and target `web02` / `db01` via the private network.
- Provider: VMware Desktop (1 GB RAM per VM, headless).
