# finance — Finance Website (Manual Provisioning)

A single CentOS Stream 9 VM that downloads and serves the "Mini Finance" HTML template via Apache HTTPD. Practises manual VM provisioning with inline shell scripts.

## VM

| Box | IP | Provider |
|-----|----|----------|
| `shk/centos-stream-9-arm64` | `192.168.56.22` | VMware Desktop |

## Provision

The VM automatically:

1. Installs `httpd wget zip unzip`
2. Downloads the Mini Finance template from `tooplate.com`
3. Extracts it to `/var/www/html/`
4. Starts and enables `httpd`

## Usage

```bash
vagrant up

# Visit the site
open http://192.168.56.22
```

## Related

See [`financeIAC`](../financeIAC/README.md) for the Infrastructure-as-Code version of this same setup.
