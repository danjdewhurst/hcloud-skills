---
name: hcloud-security
description: "Use when the user needs to manage SSH keys, TLS/SSL certificates (uploaded or managed), resource protection, reverse DNS, or labels across Hetzner Cloud resources."
---

# Hetzner Cloud Security

## SSH Keys

### Create an SSH Key

```
hcloud ssh-key create [options] --name <name> (--public-key <key> | --public-key-from-file <file>)
```

| Flag | Description |
|------|-------------|
| `--name` | Key name (required) |
| `--public-key` | Public key string |
| `--public-key-from-file` | Path to file containing the public key |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `-o, --output` | Output options: `json\|yaml` |

### List SSH Keys

```
hcloud ssh-key list [options]
```

Columns: `id`, `name`, `fingerprint`, `public_key`, `age`, `created`, `labels`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe an SSH Key

```
hcloud ssh-key describe [options] <ssh-key>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete SSH Keys

```
hcloud ssh-key delete <ssh-key>...
```

Accepts one or more SSH keys by name or ID.

### Update an SSH Key

```
hcloud ssh-key update [options] <ssh-key>
```

| Flag | Description |
|------|-------------|
| `--name` | New SSH key name |

### Labels

```
hcloud ssh-key add-label [--overwrite] <ssh-key> <label>...
hcloud ssh-key remove-label <ssh-key> (--all | <label>...)
```

---

## Certificates

### Create a Certificate (Uploaded)

```
hcloud certificate create --name <name> --type uploaded --cert-file <file> --key-file <file>
```

| Flag | Description |
|------|-------------|
| `--name` | Certificate name (required) |
| `-t, --type` | Certificate type: `uploaded` or `managed` (default: `uploaded`) |
| `--cert-file` | File containing the PEM encoded certificate (required for `uploaded`) |
| `--key-file` | File containing the PEM encoded private key (required for `uploaded`) |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `-o, --output` | Output options: `json\|yaml` |

### Create a Certificate (Managed)

```
hcloud certificate create --name <name> --type managed --domain <domain>
```

| Flag | Description |
|------|-------------|
| `--name` | Certificate name (required) |
| `-t, --type` | Must be `managed` |
| `--domain` | Domain the certificate is valid for (repeatable for multiple domains) |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `-o, --output` | Output options: `json\|yaml` |

### Retry Managed Certificate Issuance

```
hcloud certificate retry <certificate>
```

Retries issuance of a managed certificate that failed.

### List Certificates

```
hcloud certificate list [options]
```

Columns: `id`, `name`, `type`, `domain_names`, `not_valid_after`, `not_valid_before`, `fingerprint`, `issuance_status`, `renewal_status`, `age`, `created`, `labels`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Certificate

```
hcloud certificate describe [options] <certificate>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Certificates

```
hcloud certificate delete <certificate>...
```

Accepts one or more certificates by name or ID.

### Update a Certificate

```
hcloud certificate update [options] <certificate>
```

| Flag | Description |
|------|-------------|
| `--name` | New certificate name |

### Labels

```
hcloud certificate add-label [--overwrite] <certificate> <label>...
hcloud certificate remove-label <certificate> (--all | <label>...)
```

---

## Cross-Resource Protection

Protection prevents accidental deletion (and rebuild for servers). Enable or disable protection per resource type:

### Server Protection

```
hcloud server enable-protection <server> (delete|rebuild)...
hcloud server disable-protection <server> (delete|rebuild)...
```

Servers support two protection types: `delete` and `rebuild`. Specify one or both.

### Other Resource Protection

Networks, volumes, floating IPs, primary IPs, load balancers, and images support `delete` protection:

```
hcloud network enable-protection <network> delete
hcloud network disable-protection <network> delete

hcloud volume enable-protection <volume> delete
hcloud volume disable-protection <volume> delete

hcloud floating-ip enable-protection <floating-ip> delete
hcloud floating-ip disable-protection <floating-ip> delete

hcloud primary-ip enable-protection <primary-ip> delete
hcloud primary-ip disable-protection <primary-ip> delete

hcloud load-balancer enable-protection <load-balancer> delete
hcloud load-balancer disable-protection <load-balancer> delete

hcloud image enable-protection <image> delete
hcloud image disable-protection <image> delete
```

---

## Cross-Resource Reverse DNS

Set reverse DNS (PTR) records on resources with public IP addresses. Use `--ip` to target a specific address when the resource has multiple IPs.

### Server

```
hcloud server set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <server>
```

### Floating IP

```
hcloud floating-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <floating-ip>
```

### Primary IP

```
hcloud primary-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <primary-ip>
```

### Load Balancer

```
hcloud load-balancer set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <load-balancer>
```

### Reverse DNS Flags

| Flag | Description |
|------|-------------|
| `-i, --ip` | IP address for which the reverse DNS entry should be set |
| `-r, --hostname` | Hostname to set as a reverse DNS PTR entry |
| `--reset` | Reset the reverse DNS entry to the default value |

---

## Cross-Resource Labels

All managed resources support labels for organisation and filtering.

### Add Labels

```
hcloud <resource> add-label [--overwrite] <id-or-name> <label>...
```

Labels use `key=value` format. Use `--overwrite` (`-o`) to replace an existing label key.

Supported resources: `server`, `network`, `volume`, `floating-ip`, `primary-ip`, `load-balancer`, `firewall`, `image`, `ssh-key`, `certificate`, `placement-group`

### Remove Labels

```
hcloud <resource> remove-label <id-or-name> (--all | <label>...)
```

| Flag | Description |
|------|-------------|
| `-a, --all` | Remove all labels from the resource |

### Filtering by Labels

Use label selectors on any `list` command to filter results:

```
hcloud server list -l env=production
hcloud server list -l 'env=production,team=backend'
hcloud server list -l 'env!=staging'
hcloud network list -l project=myapp
```

### Labels for Firewall Targeting

Firewalls can target servers by label selector instead of individual server IDs:

```
hcloud firewall apply-to-resource --type label_selector --label-selector 'env=production' <firewall>
hcloud firewall remove-from-resource --type label_selector --label-selector 'env=production' <firewall>
```
