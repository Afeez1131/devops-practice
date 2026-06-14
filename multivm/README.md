# multivm — Multi-VM Networking Lab

A three-node Vagrant setup that explores multi-machine networking and mixed-distro environments. Two Ubuntu web nodes and one CentOS database node, all connected on a private network.

## VMs

| Name | Box | IP | Role |
|------|-----|----|------|
| `web01` | `spox/ubuntu-arm` | `192.168.56.40` | Web server node 1 |
| `web02` | `spox/ubuntu-arm` | `192.168.56.42` | Web server node 2 |
| `db01` | `shk/centos-stream-9-arm64` | `192.168.56.46` | MariaDB database |

## Provision

`db01` automatically installs and enables MariaDB:

```bash
yum install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
```

`web01` and `web02` boot clean — add your own provisioning or SSH in to experiment.

## Usage

```bash
vagrant up

# SSH into any node
vagrant ssh web01
vagrant ssh db01

# Test connectivity between nodes (from web01)
ping 192.168.56.46
mysql -h 192.168.56.46 -u root
```

## Learning objectives

- Multi-machine Vagrantfile syntax (`config.vm.define`)
- Private network routing between VMs
- Mixed-distribution environments (Ubuntu + CentOS)
