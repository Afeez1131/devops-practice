# wordpress — WordPress (Manual Provisioning)

A single Ubuntu ARM VM that sets up a complete WordPress installation — Apache, PHP, MySQL, and WordPress itself — all scripted inline in the Vagrantfile.

## VM

| Box | IP | Provider |
|-----|----|----------|
| `spox/ubuntu-arm` | `192.168.56.24` | VMware Desktop |

## What gets provisioned

1. **Apache2** with `mod-php` and required PHP extensions (`php-mysql`, `php-xml`, `php-mbstring`, etc.)
2. **MySQL** — creates the `wordpress` database and user
3. **WordPress** — downloaded from `wordpress.org`, extracted to `/srv/www/wordpress`
4. **Apache vhost** — `wordpress.conf` configured and enabled
5. **wp-config.php** — DB credentials injected via `sed`; salts fetched from the WordPress API

## Usage

```bash
vagrant up

# WordPress setup wizard
open http://192.168.56.24
```

## Related

See [`wordpressIAC`](../wordpressIAC/README.md) for the IAC-refactored version.
