# fedora — Fedora 40 Sandbox

A bare-bones single-VM environment running Fedora 40. Used to explore DNF package management and Fedora-specific tooling.

## VM

| Box | Version | Provider |
|-----|---------|----------|
| `gutehall/fedora40` | `2024.05.15` | VMware Desktop (default) |

## Usage

```bash
vagrant up
vagrant ssh
```

No automatic provisioning — the VM boots clean so you can experiment interactively.
