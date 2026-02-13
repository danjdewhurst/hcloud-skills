---
name: hcloud-networking
description: "Use when the user needs to manage Hetzner Cloud networking resources including networks, subnets, routes, firewalls, firewall rules, floating IPs, primary IPs, load balancers, load balancer services and targets, or vSwitch integration."
---

# Hetzner Cloud Networking

## Networks

### Create a Network

```
hcloud network create --name <name> --ip-range <cidr>
```

| Flag | Description |
|------|-------------|
| `--name` | Network name (required) |
| `--ip-range` | Network IP range in CIDR notation (required) |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `--enable-protection` | Enable protection: `delete` |
| `--expose-routes-to-vswitch` | Expose routes to connected vSwitch |
| `-o, --output` | Output options: `json\|yaml` |

### List Networks

```
hcloud network list
```

Columns: `id`, `name`, `ip_range`, `servers`, `age`, `created`, `labels`, `protection`, `expose_routes_to_v_switch`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Network

```
hcloud network describe <network>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Networks

```
hcloud network delete <network>...
```

Accepts one or more networks by name or ID.

### Update a Network

```
hcloud network update --name <name> <network>
```

### Add a Subnet

```
hcloud network add-subnet --network-zone <zone> --type <cloud|server|vswitch> <network>
```

| Flag | Description |
|------|-------------|
| `--network-zone` | Name of network zone (required) |
| `--type` | Subnet type: `cloud`, `server`, or `vswitch` (required) |
| `--ip-range` | Range to allocate IPs from |
| `--vswitch-id` | ID of the vSwitch (required when type is `vswitch`) |

### Remove a Subnet

```
hcloud network remove-subnet --ip-range <cidr> <network>
```

| Flag | Description |
|------|-------------|
| `--ip-range` | IP range of the subnet to remove (required) |

### Add a Route

```
hcloud network add-route --destination <cidr> --gateway <ip> <network>
```

| Flag | Description |
|------|-------------|
| `--destination` | Destination network or host in CIDR notation (required) |
| `--gateway` | Gateway IP address (required) |

### Remove a Route

```
hcloud network remove-route --destination <cidr> --gateway <ip> <network>
```

| Flag | Description |
|------|-------------|
| `--destination` | Destination network or host in CIDR notation (required) |
| `--gateway` | Gateway IP address (required) |

### Change IP Range

```
hcloud network change-ip-range --ip-range <cidr> <network>
```

The new range must contain the existing range. You can only expand, not shrink.

### Expose Routes to vSwitch

```
hcloud network expose-routes-to-vswitch [--disable] <network>
```

Enables exposing routes to the connected vSwitch. Use `--disable` to remove exposed routes.

### Labels and Protection

```
hcloud network add-label [--overwrite] <network> <key=value>...
hcloud network remove-label <network> (--all | <key>...)
hcloud network enable-protection <network> delete
hcloud network disable-protection <network> delete
```

---

## Firewalls

### Create a Firewall

```
hcloud firewall create --name <name>
```

| Flag | Description |
|------|-------------|
| `--name` | Firewall name (required) |
| `--rules-file` | JSON file containing rules (use `-` for stdin); structure must match the API |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `-o, --output` | Output options: `json\|yaml` |

### List Firewalls

```
hcloud firewall list
```

Columns: `id`, `name`, `rules_count`, `applied_to_count`, `age`, `created`, `labels`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Firewall

```
hcloud firewall describe <firewall>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Firewalls

```
hcloud firewall delete <firewall>...
```

Accepts one or more firewalls by name or ID.

### Update a Firewall

```
hcloud firewall update --name <name> <firewall>
```

### Add a Rule

```
hcloud firewall add-rule [options] (--direction in --source-ips <ips> | --direction out --destination-ips <ips>) (--protocol <tcp|udp> --port <port> | --protocol <icmp|esp|gre>) <firewall>
```

| Flag | Description |
|------|-------------|
| `--direction` | Direction: `in` or `out` (required) |
| `--protocol` | Protocol: `tcp`, `udp`, `icmp`, `esp`, or `gre` (required) |
| `--port` | Port or port range (e.g. `80` or `80-85`); only for `tcp`/`udp` |
| `--source-ips` | Source IPs in CIDR notation (required when direction is `in`) |
| `--destination-ips` | Destination IPs in CIDR notation (required when direction is `out`) |
| `--description` | Description of the rule |

### Delete a Rule

```
hcloud firewall delete-rule [options] (--direction in --source-ips <ips> | --direction out --destination-ips <ips>) (--protocol <tcp|udp> --port <port> | --protocol <icmp|esp|gre>) <firewall>
```

Uses the same flags as `add-rule` to identify and remove the matching rule.

### Replace All Rules

```
hcloud firewall replace-rules --rules-file <file> <firewall>
```

Replaces all rules from a JSON file. Use `-` to read from stdin. The JSON structure must match the Hetzner Cloud API format.

### Apply Firewall to a Resource

```
hcloud firewall apply-to-resource --type <server|label_selector> <firewall>
```

| Flag | Description |
|------|-------------|
| `--type` | Resource type: `server` or `label_selector` (required) |
| `--server` | Server name or ID (required when type is `server`) |
| `-l, --label-selector` | Label selector (required when type is `label_selector`) |

### Remove Firewall from a Resource

```
hcloud firewall remove-from-resource --type <server|label_selector> <firewall>
```

Uses the same flags as `apply-to-resource`.

### Labels

```
hcloud firewall add-label [--overwrite] <firewall> <key=value>...
hcloud firewall remove-label <firewall> (--all | <key>...)
```

---

## Floating IPs

### Create a Floating IP

```
hcloud floating-ip create --type <ipv4|ipv6> (--home-location <location> | --server <server>)
```

| Flag | Description |
|------|-------------|
| `--type` | IP type: `ipv4` or `ipv6` (required) |
| `--home-location` | Home location (mutually exclusive with `--server`) |
| `--server` | Server to assign the IP to (mutually exclusive with `--home-location`) |
| `--name` | Floating IP name |
| `--description` | Description |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `--enable-protection` | Enable protection: `delete` |
| `-o, --output` | Output options: `json\|yaml` |

### List Floating IPs

```
hcloud floating-ip list
```

Columns: `id`, `name`, `type`, `ip`, `server`, `home`, `dns`, `description`, `age`, `created`, `labels`, `protection`, `blocked`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Floating IP

```
hcloud floating-ip describe <floating-ip>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Floating IPs

```
hcloud floating-ip delete <floating-ip>...
```

Accepts one or more floating IPs by name or ID.

### Update a Floating IP

```
hcloud floating-ip update <floating-ip>
```

| Flag | Description |
|------|-------------|
| `--name` | New name |
| `--description` | New description |

### Assign a Floating IP

```
hcloud floating-ip assign <floating-ip> <server>
```

### Unassign a Floating IP

```
hcloud floating-ip unassign <floating-ip>
```

### Set Reverse DNS

```
hcloud floating-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <floating-ip>
```

| Flag | Description |
|------|-------------|
| `-i, --ip` | IP address for which the reverse DNS entry should be set |
| `-r, --hostname` | Hostname to set as a reverse DNS PTR entry |
| `--reset` | Reset the reverse DNS entry to the default value |

### Protection and Labels

```
hcloud floating-ip enable-protection <floating-ip> delete
hcloud floating-ip disable-protection <floating-ip> delete
hcloud floating-ip add-label [--overwrite] <floating-ip> <key=value>...
hcloud floating-ip remove-label <floating-ip> (--all | <key>...)
```

---

## Primary IPs

### Create a Primary IP

```
hcloud primary-ip create --type <ipv4|ipv6> --name <name>
```

| Flag | Description |
|------|-------------|
| `--type` | IP type: `ipv4` or `ipv6` (required) |
| `--name` | Primary IP name (required) |
| `--location` | Location (ID or name) |
| `--assignee-id` | Assignee (usually a server) to assign the IP to |
| `--auto-delete` | Delete the IP when the assigned resource is deleted |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `--enable-protection` | Enable protection: `delete` |
| `-o, --output` | Output options: `json\|yaml` |

> **Note:** The `--datacenter` flag is deprecated. Use `--location` or `--assignee-id` instead.

### List Primary IPs

```
hcloud primary-ip list
```

Columns: `id`, `name`, `type`, `ip`, `assignee`, `assignee_id`, `assignee_type`, `auto_delete`, `dns`, `age`, `created`, `labels`, `protection`, `blocked`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Primary IP

```
hcloud primary-ip describe <primary-ip>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Primary IPs

```
hcloud primary-ip delete <primary-ip>...
```

Accepts one or more primary IPs by name or ID.

### Update a Primary IP

```
hcloud primary-ip update <primary-ip>
```

| Flag | Description |
|------|-------------|
| `--name` | New name |
| `--auto-delete` | Delete the IP when the assigned resource is deleted |

### Assign a Primary IP

```
hcloud primary-ip assign --server <server> <primary-ip>
```

### Unassign a Primary IP

```
hcloud primary-ip unassign <primary-ip>
```

### Set Reverse DNS

```
hcloud primary-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <primary-ip>
```

| Flag | Description |
|------|-------------|
| `-i, --ip` | IP address for which the reverse DNS entry should be set |
| `-r, --hostname` | Hostname to set as a reverse DNS PTR entry |
| `--reset` | Reset the reverse DNS entry to the default value |

### Protection and Labels

```
hcloud primary-ip enable-protection <primary-ip> delete
hcloud primary-ip disable-protection <primary-ip> delete
hcloud primary-ip add-label [--overwrite] <primary-ip> <key=value>...
hcloud primary-ip remove-label <primary-ip> (--all | <key>...)
```

---

## Load Balancers

### Create a Load Balancer

```
hcloud load-balancer create --name <name> --type <type>
```

| Flag | Description |
|------|-------------|
| `--name` | Load balancer name (required) |
| `--type` | Load balancer type ID or name (required) |
| `--algorithm-type` | Algorithm: `round_robin` or `least_connections` |
| `--location` | Location (ID or name) |
| `--network` | Network (ID or name) to attach on creation |
| `--network-zone` | Network zone |
| `--label` | User-defined labels as `key=value` (repeatable) |
| `--enable-protection` | Enable protection: `delete` |
| `-o, --output` | Output options: `json\|yaml` |

### List Load Balancers

```
hcloud load-balancer list
```

Columns: `id`, `name`, `type`, `ipv4`, `ipv6`, `location`, `network_zone`, `health`, `age`, `created`, `labels`, `protection`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Load Balancer

```
hcloud load-balancer describe <load-balancer>
```

| Flag | Description |
|------|-------------|
| `--expand-targets` | Expand all label_selector targets |
| `-o, --output` | Output options: `json\|yaml\|format` |

### Delete Load Balancers

```
hcloud load-balancer delete <load-balancer>...
```

Accepts one or more load balancers by name or ID.

### Update a Load Balancer

```
hcloud load-balancer update --name <name> <load-balancer>
```

### Add a Service

```
hcloud load-balancer add-service [options] (--protocol http | --protocol tcp --listen-port <1-65535> --destination-port <1-65535> | --protocol https --http-certificates <ids>) <load-balancer>
```

| Flag | Description |
|------|-------------|
| `--protocol` | Protocol: `http`, `tcp`, or `https` (required) |
| `--listen-port` | Listen port of the service |
| `--destination-port` | Destination port on targets |
| `--http-certificates` | IDs or names of certificates (for `https`) |
| `--http-redirect-http` | Redirect port 80 to port 443 |
| `--http-sticky-sessions` | Enable sticky sessions |
| `--http-cookie-name` | Sticky sessions cookie name |
| `--http-cookie-lifetime` | Sticky sessions cookie lifetime |
| `--proxy-protocol` | Enable proxy protocol |

Health check flags:

| Flag | Default | Description |
|------|---------|-------------|
| `--health-check-protocol` | | Health check protocol |
| `--health-check-port` | | Health check port |
| `--health-check-interval` | `15s` | Interval between health checks |
| `--health-check-timeout` | `10s` | Timeout before marking unhealthy |
| `--health-check-retries` | `3` | Retries before marking as failed |
| `--health-check-http-domain` | | Domain for HTTP health checks |
| `--health-check-http-path` | | Path for HTTP health checks |
| `--health-check-http-response` | | Expected response body |
| `--health-check-http-status-codes` | | Expected status codes |
| `--health-check-http-tls` | | Verify TLS certificate on health check |

### Update a Service

```
hcloud load-balancer update-service --listen-port <port> <load-balancer>
```

Identifies the service by `--listen-port` and accepts all the same flags as `add-service` to modify properties.

### Delete a Service

```
hcloud load-balancer delete-service --listen-port <port> <load-balancer>
```

### Add a Target

```
hcloud load-balancer add-target [options] (--server <server> | --label-selector <selector> | --ip <ip>) <load-balancer>
```

| Flag | Description |
|------|-------------|
| `--server` | Server name or ID |
| `--label-selector` | Label selector for server targets |
| `--ip` | IP address for IP targets |
| `--use-private-ip` | Connect to target via private network |

### Remove a Target

```
hcloud load-balancer remove-target [options] <load-balancer>
```

| Flag | Description |
|------|-------------|
| `--server` | Server name or ID |
| `--label-selector` | Label selector |
| `--ip` | IP address of an IP target |

### Change Algorithm

```
hcloud load-balancer change-algorithm --algorithm-type <round_robin|least_connections> <load-balancer>
```

### Change Type

```
hcloud load-balancer change-type <load-balancer> <load-balancer-type>
```

### Attach to Network

```
hcloud load-balancer attach-to-network --network <network> <load-balancer>
```

| Flag | Description |
|------|-------------|
| `-n, --network` | Network ID or name (required) |
| `--ip` | IP address to assign (auto-assigned if omitted) |
| `--ip-range` | Subnet IP range in CIDR notation (auto-assigned if omitted) |

### Detach from Network

```
hcloud load-balancer detach-from-network --network <network> <load-balancer>
```

### Enable Public Interface

```
hcloud load-balancer enable-public-interface <load-balancer>
```

### Disable Public Interface

```
hcloud load-balancer disable-public-interface <load-balancer>
```

### Set Reverse DNS

```
hcloud load-balancer set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <load-balancer>
```

| Flag | Description |
|------|-------------|
| `-i, --ip` | IP address for which the reverse DNS entry should be set |
| `-r, --hostname` | Hostname to set as a reverse DNS PTR entry |
| `--reset` | Reset the reverse DNS entry to the default value |

### Protection and Labels

```
hcloud load-balancer enable-protection <load-balancer> delete
hcloud load-balancer disable-protection <load-balancer> delete
hcloud load-balancer add-label [--overwrite] <load-balancer> <key=value>...
hcloud load-balancer remove-label <load-balancer> (--all | <key>...)
```

---

## Load Balancer Types

### List Load Balancer Types

```
hcloud load-balancer-type list
```

Columns: `id`, `name`, `description`, `max_connections`, `max_services`, `max_targets`, `max_assigned_certificates`

| Flag | Description |
|------|-------------|
| `-l, --selector` | Filter by label selector |
| `-s, --sort` | Sort results |
| `-o, --output` | Output options: `noheader\|columns=...\|json\|yaml` |

### Describe a Load Balancer Type

```
hcloud load-balancer-type describe <load-balancer-type>
```

| Flag | Description |
|------|-------------|
| `-o, --output` | Output options: `json\|yaml\|format` |
