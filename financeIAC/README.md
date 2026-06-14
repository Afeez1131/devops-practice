# financeIAC — Finance Website (Infrastructure as Code)

The Infrastructure-as-Code counterpart to the [`finance`](../finance/README.md) project. Same CentOS/Apache stack, refactored into a repeatable, idempotent Vagrantfile that is committed to source control.

## VM

| Box | IP | Provider |
|-----|----|----------|
| `shk/centos-stream-9-arm64` | `192.168.56.26` | VMware Desktop |

## What makes this "IAC"

- The `Vagrantfile` is the single source of truth — no manual steps after `vagrant up`.
- All provisioning is declared inline in the file, version-controlled, and reproducible.
- Demonstrates the difference between imperative (click-ops / ad-hoc scripts) and declarative infrastructure.

## Usage

```bash
vagrant up

open http://192.168.56.26
```

## Key learning

Comparing this folder side-by-side with `../finance` shows how the same outcome can be achieved with or without IAC principles.
