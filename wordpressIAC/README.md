# wordpressIAC — WordPress (Infrastructure as Code)

The Infrastructure-as-Code evolution of the [`wordpress`](../wordpress/README.md) project. The same stack (Apache + PHP + MySQL + WordPress on Ubuntu ARM) is fully declared in a version-controlled Vagrantfile with no manual steps.

## VM

| Box | IP | Provider |
|-----|----|----------|
| `spox/ubuntu-arm` | `192.168.56.28` | VMware Desktop |

## Usage

```bash
vagrant up

open http://192.168.56.28
```

## Key learning

This folder and `../wordpress` demonstrate the IAC principle: the Vagrantfile is the definitive description of the infrastructure — destroy and recreate at any time and get exactly the same result.
