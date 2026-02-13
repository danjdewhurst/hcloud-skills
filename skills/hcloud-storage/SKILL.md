---
name: hcloud-storage
description: "Use when the user needs to manage Hetzner Cloud storage including volumes (block storage), storage boxes, storage box subaccounts, storage box snapshots, or storage box types."
---

# Hetzner Cloud Storage

## Volumes (Block Storage)

### Create a Volume

```bash
hcloud volume create [options] --name <name> --size <size>
```

Flags:
- `--name <name>` - Volume name (required)
- `--size <gb>` - Size in GB (required)
- `--server <server>` - Server ID or name to attach to
- `--location <location>` - Location ID or name
- `--automount` - Automount Volume after attach (server must be provided)
- `--format <ext4|xfs>` - Format Volume after creation
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `--enable-protection <delete>` - Enable protection (value: delete)
- `-o, --output json|yaml` - Output format

### List Volumes

```bash
hcloud volume list [options]
```

Columns: id, name, size, server, location, status, linux_device, age, created, labels, protection

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Volume

```bash
hcloud volume describe [options] <volume>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Volumes

```bash
hcloud volume delete <volume>...
```

Accepts one or more volume IDs or names.

### Update a Volume

```bash
hcloud volume update [options] <volume>
```

Flags:
- `--name <name>` - New volume name

### Attach a Volume to a Server

```bash
hcloud volume attach [--automount] --server <server> <volume>
```

Flags:
- `--server <server>` - Server ID or name (required)
- `--automount` - Automount Volume after attach

### Detach a Volume

```bash
hcloud volume detach <volume>
```

### Resize a Volume

```bash
hcloud volume resize --size <size> <volume>
```

Flags:
- `--size <gb>` - New size in GB (required)

### Labels and Protection

#### Add Label

```bash
hcloud volume add-label [--overwrite] <volume> <label>...
```

Labels use `key=value` format.

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

#### Remove Label

```bash
hcloud volume remove-label <volume> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

#### Enable Protection

```bash
hcloud volume enable-protection <volume> delete
```

#### Disable Protection

```bash
hcloud volume disable-protection <volume> delete
```

## Storage Boxes

### Create a Storage Box

```bash
hcloud storage-box create [options] --name <name> --type <type> --location <location> --password <password>
```

Flags:
- `--name <name>` - Storage Box name (required)
- `--type <type>` - Storage Box Type ID or name (required)
- `--location <location>` - Location ID or name (required)
- `--password <password>` - Password for the Storage Box (required)
- `--enable-samba` - Enable Samba subsystem
- `--enable-ssh` - Enable SSH subsystem
- `--enable-webdav` - Enable WebDAV subsystem
- `--enable-zfs` - Enable ZFS Snapshot folder visibility
- `--reachable-externally` - Allow access from outside the Hetzner network
- `--ssh-key <key>` - SSH public key in OpenSSH format or SSH key ID/name (can be specified multiple times)
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `--enable-protection <delete>` - Enable protection (value: delete)
- `-o, --output json|yaml` - Output format

### List Storage Boxes

```bash
hcloud storage-box list [options]
```

Columns: id, name, size, location, status, system, type, username, server, age, created, labels

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Storage Box

```bash
hcloud storage-box describe [options] <storage-box>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Storage Boxes

```bash
hcloud storage-box delete <storage-box>...
```

Accepts one or more Storage Box IDs or names.

### Update a Storage Box

```bash
hcloud storage-box update [options] <storage-box>
```

Flags:
- `--name <name>` - New Storage Box name

### Change Storage Box Type

```bash
hcloud storage-box change-type <storage-box> <storage-box-type>
```

Upgrades or downgrades to another Storage Box Type. Cannot downgrade to a type with less disk space than currently used.

### Update Access Settings

```bash
hcloud storage-box update-access-settings [options] <storage-box>
```

Flags:
- `--enable-samba` - Enable or disable Samba subsystem (true, false)
- `--enable-ssh` - Enable or disable SSH subsystem (true, false)
- `--enable-webdav` - Enable or disable WebDAV subsystem (true, false)
- `--enable-zfs` - Enable or disable ZFS Snapshot folder visibility (true, false)
- `--reachable-externally` - Allow or disallow access from outside the Hetzner network (true, false)

### Reset Password

```bash
hcloud storage-box reset-password --password <password> <storage-box>
```

Flags:
- `--password <password>` - New password for the Storage Box

### List Folders

```bash
hcloud storage-box folders <storage-box>
```

Flags:
- `--path <path>` - Relative path for which the listing is to be made
- `-o, --output json|yaml` - Output format

### Automatic Snapshot Plan

#### Enable Snapshot Plan

```bash
hcloud storage-box enable-snapshot-plan [options] <storage-box>
```

Flags:
- `--hour <hour>` - Hour the plan executes (UTC)
- `--minute <minute>` - Minute the plan executes (UTC)
- `--day-of-week <day>` - Day of the week (Sun-Sat, 0-7)
- `--day-of-month <day>` - Day of the month
- `--max-snapshots <count>` - Maximum snapshots to retain

#### Disable Snapshot Plan

```bash
hcloud storage-box disable-snapshot-plan <storage-box>
```

### Labels and Protection

#### Add Label

```bash
hcloud storage-box add-label [--overwrite] <storage-box> <label>...
```

Labels use `key=value` format.

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

#### Remove Label

```bash
hcloud storage-box remove-label <storage-box> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

#### Enable Protection

```bash
hcloud storage-box enable-protection <storage-box> delete
```

#### Disable Protection

```bash
hcloud storage-box disable-protection <storage-box> delete
```

## Storage Box Subaccounts

### Create a Subaccount

```bash
hcloud storage-box subaccount create [options] --password <password> --home-directory <home-directory> <storage-box>
```

Flags:
- `--password <password>` - Subaccount password (required)
- `--home-directory <dir>` - Home directory for the Subaccount (required)
- `--name <name>` - Subaccount name
- `--description <text>` - Subaccount description
- `--enable-samba` - Enable Samba subsystem
- `--enable-ssh` - Enable SSH subsystem
- `--enable-webdav` - Enable WebDAV subsystem
- `--reachable-externally` - Allow access from outside the Hetzner network
- `--readonly` - Make the Subaccount read-only
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `-o, --output json|yaml` - Output format

### List Subaccounts

```bash
hcloud storage-box subaccount list [options] <storage-box>
```

Columns: id, name, username, description, home_directory, server, age, created, labels

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Subaccount

```bash
hcloud storage-box subaccount describe [options] <storage-box> <subaccount>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Subaccounts

```bash
hcloud storage-box subaccount delete <storage-box> <subaccount>...
```

Accepts one or more subaccount IDs or names.

### Update a Subaccount

```bash
hcloud storage-box subaccount update [options] <storage-box> <subaccount>
```

Flags:
- `--name <name>` - New subaccount name
- `--description <text>` - New subaccount description

### Update Subaccount Access Settings

```bash
hcloud storage-box subaccount update-access-settings [options] <storage-box> <subaccount>
```

Flags:
- `--enable-samba` - Enable or disable Samba subsystem (true, false)
- `--enable-ssh` - Enable or disable SSH subsystem (true, false)
- `--enable-webdav` - Enable or disable WebDAV subsystem (true, false)
- `--reachable-externally` - Allow or disallow access from outside the Hetzner network (true, false)
- `--readonly` - Make the Subaccount read-only or writable (true, false)

### Change Subaccount Home Directory

```bash
hcloud storage-box subaccount change-home-directory --home-directory <home-directory> <storage-box> <subaccount>
```

Flags:
- `--home-directory <dir>` - New home directory (will be created if it does not exist)

### Reset Subaccount Password

```bash
hcloud storage-box subaccount reset-password --password <password> <storage-box> <subaccount>
```

Flags:
- `--password <password>` - New password for the Subaccount

## Storage Box Snapshots

### Create a Snapshot

```bash
hcloud storage-box snapshot create [options] <storage-box>
```

Flags:
- `--description <text>` - Snapshot description
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `-o, --output json|yaml` - Output format

### List Snapshots

```bash
hcloud storage-box snapshot list [options] <storage-box>
```

Columns: id, name, description, size, size_filesystem, is_automatic, age, created, labels

Flags:
- `--automatic` - Only show automatic snapshots (true, false)
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Snapshot

```bash
hcloud storage-box snapshot describe [options] <storage-box> <snapshot>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Snapshots

```bash
hcloud storage-box snapshot delete <storage-box> <snapshot>...
```

Accepts one or more snapshot IDs or names.

### Update a Snapshot

```bash
hcloud storage-box snapshot update [options] <storage-box> <snapshot>
```

Flags:
- `--description <text>` - New snapshot description

### Rollback to a Snapshot

```bash
hcloud storage-box rollback-snapshot --snapshot <snapshot> <storage-box>
```

Rolls back the Storage Box to the given Snapshot.

Flags:
- `--snapshot <snapshot>` - The name or ID of the snapshot to roll back to (required)

### Snapshot Labels

#### Add Label

```bash
hcloud storage-box snapshot add-label [--overwrite] <storage-box> <snapshot> <label>...
```

Labels use `key=value` format.

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

#### Remove Label

```bash
hcloud storage-box snapshot remove-label <storage-box> <snapshot> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

## Storage Box Types (Read-Only)

### List Storage Box Types

```bash
hcloud storage-box-type list [options]
```

Columns: id, name, description, size, snapshot_limit, subaccounts_limit, automatic_snapshot_limit, deprecated

Flags:
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Storage Box Type

```bash
hcloud storage-box-type describe [options] <storage-box-type>
```

Flags:
- `-o, --output json|yaml|format` - Output format
