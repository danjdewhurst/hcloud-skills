---
name: hcloud-servers
description: "Use when the user needs to create, manage, or operate Hetzner Cloud servers, including power management, SSH access, server types, images, snapshots, backups, rescue mode, placement groups, ISOs, or viewing locations and datacenters."
---

# Hetzner Cloud Servers

## Server Lifecycle

### Create a Server

```bash
hcloud server create [options] --name <name> --type <server-type> --image <image>
```

Flags:
- `--name <name>` - Server name (required)
- `--type <server-type>` - Server Type ID or name (required)
- `--image <image>` - Image ID or name (required)
- `--location <location>` - Location ID or name
- `--ssh-key <key>` - SSH Key ID or name (can be specified multiple times)
- `--network <network>` - Network ID or name to attach to (can be specified multiple times)
- `--firewall <firewall>` - Firewall ID or name to attach to (can be specified multiple times)
- `--volume <volume>` - Volume ID or name to attach (can be specified multiple times)
- `--user-data-from-file <file>` - Read user data from file (use `-` for stdin)
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `--placement-group <group>` - Placement Group ID or name
- `--primary-ipv4 <ip>` - Primary IPv4 ID or name
- `--primary-ipv6 <ip>` - Primary IPv6 ID or name
- `--enable-backup` - Enable automatic backups
- `--enable-protection <delete|rebuild>` - Enable protection (values: delete, rebuild)
- `--start-after-create` - Start Server after creation (default: true)
- `--without-ipv4` - Create without IPv4
- `--without-ipv6` - Create without IPv6
- `--allow-deprecated-image` - Allow use of deprecated images
- `--automount` - Automount Volumes after attach
- `-o, --output json|yaml` - Output format

### List Servers

```bash
hcloud server list [options]
```

Columns: id, name, status, type, ipv4, ipv6, location, datacenter, labels, protection, volumes, private_net, placement_group, backup_window, created, age, rescue_enabled, locked, included_traffic, ingoing_traffic, outgoing_traffic, primary_disk_size

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `--status <status>` - Filter by status (can be specified multiple times)
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Server

```bash
hcloud server describe [options] <server>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Servers

```bash
hcloud server delete <server>...
```

Accepts one or more server IDs or names.

### Update a Server

```bash
hcloud server update [options] <server>
```

Flags:
- `--name <new-name>` - New server name

## Power Management

### Power On

```bash
hcloud server poweron <server>
```

### Power Off (Hard)

```bash
hcloud server poweroff <server>
```

Immediately cuts power. Use `shutdown` for graceful ACPI shutdown.

### Shutdown (Graceful ACPI)

```bash
hcloud server shutdown [options] <server>
```

Sends an ACPI shutdown request. The OS must support ACPI.

Flags:
- `--wait` - Wait for the server to shut down before returning
- `--wait-timeout <duration>` - Timeout for waiting (default: 30s)

### Reboot (Graceful)

```bash
hcloud server reboot <server>
```

### Reset (Hard)

```bash
hcloud server reset <server>
```

Hard reset, equivalent to pressing the physical reset button.

## Access

### SSH into a Server

```bash
hcloud server ssh [options] <server> [--] [ssh options] [command [argument...]]
```

Flags:
- `-u, --user <user>` - SSH username (default: root)
- `-p, --port <port>` - SSH port (default: 22)
- `--ipv6` - Connect via IPv6 address

Pass additional SSH options after `--`.

### Get Server IP

```bash
hcloud server ip [--ipv6] <server>
```

Flags:
- `-6, --ipv6` - Print the first address of the server's primary IPv6 network

### Request VNC Console

```bash
hcloud server request-console [options] <server>
```

Returns a WebSocket URL and password for VNC console access.

Flags:
- `-o, --output json|yaml` - Output format

## Server Modifications

### Change Server Type

```bash
hcloud server change-type [--keep-disk] <server> <server-type>
```

Server must be stopped first. Requires a reboot after the change.

Flags:
- `--keep-disk` - Keep disk size of current type (enables downgrading later)

### Rebuild Server

```bash
hcloud server rebuild [options] --image <image> <server>
```

Reinstalls the server from an image. All data on the server will be lost.

Flags:
- `--image <image>` - Image ID or name (required)
- `--allow-deprecated-image` - Allow use of deprecated images
- `--user-data-from-file <file>` - Read user data from file (use `-` for stdin)

### Create Image from Server

```bash
hcloud server create-image [options] --type <snapshot|backup> <server>
```

Flags:
- `--type <snapshot|backup>` - Image type (required)
- `--description <text>` - Image description
- `--label <key=value>` - Labels (can be specified multiple times)

## Rescue Mode

### Enable Rescue Mode

```bash
hcloud server enable-rescue [options] <server>
```

Outputs a root password. Server must be rebooted to enter rescue mode.

Flags:
- `--ssh-key <key>` - SSH Key ID or name to inject (can be specified multiple times)
- `--type <type>` - Rescue type (default: linux64)

### Disable Rescue Mode

```bash
hcloud server disable-rescue <server>
```

### Reset Root Password

```bash
hcloud server reset-password [options] <server>
```

Flags:
- `-o, --output json|yaml` - Output format

## Backups

### Enable Backups

```bash
hcloud server enable-backup <server>
```

### Disable Backups

```bash
hcloud server disable-backup <server>
```

## Network Attachment

### Attach to Network

```bash
hcloud server attach-to-network [options] --network <network> <server>
```

Flags:
- `-n, --network <network>` - Network ID or name (required)
- `--ip <ip>` - IP address to assign (auto-assigned if omitted)
- `--ip-range <cidr>` - Subnet CIDR to attach to (auto-assigned if omitted)
- `--alias-ips <ip>` - Additional alias IPs (can be specified multiple times)

### Detach from Network

```bash
hcloud server detach-from-network --network <network> <server>
```

Flags:
- `-n, --network <network>` - Network ID or name (required)

### Change Alias IPs

```bash
hcloud server change-alias-ips [options] --network <network> <server>
```

Flags:
- `-n, --network <network>` - Network ID or name (required)
- `--alias-ips <ips>` - New alias IPs
- `--clear` - Remove all alias IPs

## ISO Management

### Attach ISO

```bash
hcloud server attach-iso <server> <iso>
```

### Detach ISO

```bash
hcloud server detach-iso <server>
```

## Placement Groups

### Add Server to Placement Group

```bash
hcloud server add-to-placement-group --placement-group <group> <server>
```

Flags:
- `-g, --placement-group <group>` - Placement Group ID or name (required)

### Remove Server from Placement Group

```bash
hcloud server remove-from-placement-group <server>
```

### Create Placement Group

```bash
hcloud placement-group create [options] --name <name> --type <type>
```

Flags:
- `--name <name>` - Name (required)
- `--type <type>` - Type (required, e.g. spread)
- `--label <key=value>` - Labels (can be specified multiple times)
- `-o, --output json|yaml` - Output format

### List Placement Groups

```bash
hcloud placement-group list [options]
```

Columns: id, name, servers, type, age, created

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe Placement Group

```bash
hcloud placement-group describe [options] <placement-group>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Placement Groups

```bash
hcloud placement-group delete <placement-group>...
```

## Labels and Protection

### Add Label

```bash
hcloud server add-label [--overwrite] <server> <label>...
```

Labels use `key=value` format.

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

### Remove Label

```bash
hcloud server remove-label <server> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

### Enable Protection

```bash
hcloud server enable-protection <server> (delete|rebuild)...
```

Protection types: `delete`, `rebuild`. Specify one or both.

### Disable Protection

```bash
hcloud server disable-protection <server> (delete|rebuild)...
```

### Set Reverse DNS

```bash
hcloud server set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <server>
```

Flags:
- `-i, --ip <ip>` - IP address to set rDNS for
- `-r, --hostname <hostname>` - Hostname for the PTR record
- `--reset` - Reset rDNS to default value

## Server Types (Read-Only)

### List Server Types

```bash
hcloud server-type list [options]
```

Columns: name, id, description, cores, cpu_type, architecture, memory, disk, storage_type, category, included_traffic, traffic, deprecated

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe Server Type

```bash
hcloud server-type describe [options] <server-type>
```

Flags:
- `-o, --output json|yaml|format` - Output format

## Images

### List Images

```bash
hcloud image list [options]
```

Columns: name, id, type, os_flavor, os_version, description, architecture, disk_size, image_size, created, age, deprecated, bound_to, status, protection, rapid_deploy, labels, created_from

Flags:
- `-t, --type <type>` - Filter by type: system, app, snapshot, backup
- `-a, --architecture <arch>` - Filter by architecture: x86, arm
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe Image

```bash
hcloud image describe [options] <image>
```

Flags:
- `-a, --architecture <arch>` - Architecture (default: x86)
- `-o, --output json|yaml|format` - Output format

### Delete Images

```bash
hcloud image delete <image>...
```

### Update Image

```bash
hcloud image update [options] <image>
```

Flags:
- `--description <text>` - Image description
- `--type <type>` - Image type

### Image Labels and Protection

```bash
hcloud image add-label [--overwrite] <image> <label>...
hcloud image remove-label <image> (--all | <label>...)
hcloud image enable-protection <image> delete
hcloud image disable-protection <image> delete
```

## Infrastructure Reference

### Locations

```bash
hcloud location list [options]
```

Columns: name, id, description, country, city, network_zone, latitude, longitude

Flags:
- `-o, --output noheader|columns=...|json|yaml` - Output options

```bash
hcloud location describe [options] <location>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Datacenters (Deprecated)

Datacenters are deprecated. Use locations instead.

```bash
hcloud datacenter list [options]
```

Columns: name, id, description, location

```bash
hcloud datacenter describe [options] <datacenter>
```

### ISOs

```bash
hcloud iso list [options]
```

Columns: id, name, description, type, architecture

Flags:
- `--architecture <arch>` - Filter by architecture: x86, arm
- `--type <type>` - Filter by type: public, private (default: both)
- `--include-architecture-wildcard` - Include ISOs with unknown architecture (for custom ISOs with architecture filter)
- `-o, --output noheader|columns=...|json|yaml` - Output options

```bash
hcloud iso describe [options] <iso>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### List All Resources

```bash
hcloud all list [options]
```

Lists all project resources (servers, images, volumes, networks, firewalls, etc.). Does not include static/public resources like locations or public ISOs.

Flags:
- `--paid` - Only list resources that cost money
- `-l, --selector <label>` - Filter by label selector
- `-o, --output json|yaml` - Output format
