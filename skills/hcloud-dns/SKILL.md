---
name: hcloud-dns
description: "Use when the user needs to manage Hetzner DNS zones, DNS records (RRSets), zone files, TTL configuration, nameservers, or any DNS-related operations."
---

# Hetzner Cloud DNS

## Zone Lifecycle

### Create a Zone

```bash
hcloud zone create [options] --name <name>
```

Flags:
- `--name <name>` - Zone name / domain (required)
- `--ttl <seconds>` - Default Time To Live (TTL) of the Zone
- `--mode <mode>` - Mode of the Zone: primary, secondary (default: primary)
- `--zonefile <file>` - Zone file in BIND (RFC 1034/1035) format (use `-` to read from stdin)
- `--primary-nameservers-file <file>` - JSON file containing primary nameservers (for secondary zones)
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `--enable-protection <delete>` - Enable protection (default: none)
- `-o, --output json|yaml` - Output format

### List Zones

```bash
hcloud zone list [options]
```

Columns: id, name, name_idna, status, ttl, mode, authoritative_nameservers, primary_nameservers, registrar, record_count, age, created, labels, protection

Flags:
- `--mode <mode>` - Filter by zone mode
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe a Zone

```bash
hcloud zone describe [options] <zone>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete Zones

```bash
hcloud zone delete <zone>...
```

Accepts one or more zone IDs or names.

## Zone Configuration

### Change Default TTL

```bash
hcloud zone change-ttl --ttl <seconds> <zone>
```

Flags:
- `--ttl <seconds>` - Default Time To Live (TTL) of the Zone (required, default: 3600)

### Change Primary Nameservers

```bash
hcloud zone change-primary-nameservers --primary-nameservers-file <file> <zone>
```

Changes the primary nameservers of a secondary Zone.

Flags:
- `--primary-nameservers-file <file>` - JSON file containing the new primary nameservers (use `-` to read from stdin)

The input file must be JSON. Example:

```json
[
  { "address": "203.0.113.10" },
  { "address": "203.0.113.11", "port": 5353 },
  { "address": "203.0.113.12", "tsig_algorithm": "hmac-sha256", "tsig_key": "example-key" }
]
```

### Export Zone File

```bash
hcloud zone export-zonefile [options] <zone>
```

Returns a generated zone file in BIND (RFC 1034/1035) format.

Flags:
- `-o, --output json|yaml` - Output format

### Import Zone File

```bash
hcloud zone import-zonefile --zonefile <file> <zone>
```

Imports a zone file, replacing all Zone RRSets.

Flags:
- `--zonefile <file>` - Zone file in BIND (RFC 1034/1035) format (use `-` to read from stdin)
- `-o, --output json|yaml` - Output format

## Zone Labels and Protection

### Add Label

```bash
hcloud zone add-label [--overwrite] <zone> <label>...
```

Labels use `key=value` format.

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

### Remove Label

```bash
hcloud zone remove-label <zone> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

### Enable Protection

```bash
hcloud zone enable-protection <zone> delete
```

Protection type: `delete`.

### Disable Protection

```bash
hcloud zone disable-protection <zone> delete
```

## RRSets (DNS Records)

An RRSet is a set of DNS records sharing the same name and type within a zone. RRSets can be managed via the `hcloud zone rrset` subcommands or equivalent shortcut commands directly under `hcloud zone`.

Supported record types: A, AAAA, CAA, CNAME, DS, HINFO, HTTPS, MX, NS, PTR, RP, SOA, SRV, SVCB, TLSA, TXT

TXT records must consist of one or more quoted strings of up to 255 characters. Unquoted TXT values are automatically formatted.

### Create an RRSet

```bash
hcloud zone rrset create [options] --name <name> --type <type> (--record <value>... | --records-file <file>) <zone>
```

Flags:
- `--name <name>` - Name of the RRSet (required)
- `--type <type>` - Record type (required): A, AAAA, CAA, CNAME, DS, HINFO, HTTPS, MX, NS, PTR, RP, SOA, SRV, SVCB, TLSA, TXT
- `--record <value>` - Record value (can be specified multiple times, conflicts with `--records-file`)
- `--records-file <file>` - JSON file containing the records (conflicts with `--record`)
- `--ttl <seconds>` - Time To Live (TTL) of the RRSet
- `--label <key=value>` - User-defined labels (can be specified multiple times)
- `-o, --output json|yaml` - Output format

### List RRSets

```bash
hcloud zone rrset list [options] <zone>
```

Columns: id, name, ttl, type, records, labels, protection

Flags:
- `--type <type>` - Filter by record type (can be specified multiple times)
- `-l, --selector <label>` - Filter by label selector
- `-s, --sort <field>` - Sort results
- `-o, --output noheader|columns=...|json|yaml` - Output options

### Describe an RRSet

```bash
hcloud zone rrset describe [options] <zone> <name> <type>
```

Flags:
- `-o, --output json|yaml|format` - Output format

### Delete an RRSet

```bash
hcloud zone rrset delete <zone> <name> <type>
```

Deletes the entire RRSet (all records with the given name and type).

### Add Records to an RRSet

```bash
hcloud zone rrset add-records (--record <value>... | --records-file <file>) <zone> <name> <type>
```

If the RRSet does not exist, it will automatically be created.

Flags:
- `--record <value>` - Record value (can be specified multiple times, conflicts with `--records-file`)
- `--records-file <file>` - JSON file containing the records (conflicts with `--record`)
- `--ttl <seconds>` - Time To Live (TTL) of the RRSet

Shortcut: `hcloud zone add-records` provides identical functionality.

### Remove Records from an RRSet

```bash
hcloud zone rrset remove-records (--record <value>... | --records-file <file>) <zone> <name> <type>
```

If the RRSet has no remaining records, it will automatically be deleted.

Flags:
- `--record <value>` - Record value (can be specified multiple times, conflicts with `--records-file`)
- `--records-file <file>` - JSON file containing the records (conflicts with `--record`)

Shortcut: `hcloud zone remove-records` provides identical functionality.

### Set Records of an RRSet

```bash
hcloud zone rrset set-records (--record <value>... | --records-file <file>) <zone> <name> <type>
```

Replaces all records in the RRSet. If the RRSet does not exist, it will be created. If the provided records are empty, the RRSet will be deleted.

Flags:
- `--record <value>` - Record value (can be specified multiple times, conflicts with `--records-file`)
- `--records-file <file>` - JSON file containing the records (conflicts with `--record`)

Shortcut: `hcloud zone set-records` provides identical functionality.

### Change RRSet TTL

```bash
hcloud zone rrset change-ttl (--ttl <seconds> | --unset) <zone> <name> <type>
```

Flags:
- `--ttl <seconds>` - Time To Live (TTL) of the RRSet (required unless `--unset`)
- `--unset` - Unset the TTL so the RRSet uses the Zone default TTL instead

## RRSet Labels and Protection

### Add Label

```bash
hcloud zone rrset add-label [--overwrite] <zone> <name> <type> <label>...
```

Flags:
- `-o, --overwrite` - Overwrite if label key already exists

### Remove Label

```bash
hcloud zone rrset remove-label <zone> <name> <type> (--all | <label>...)
```

Flags:
- `-a, --all` - Remove all labels

### Enable Protection

```bash
hcloud zone rrset enable-protection <zone> <name> <type> change
```

Protection type: `change`. Prevents modifications to the RRSet.

### Disable Protection

```bash
hcloud zone rrset disable-protection <zone> <name> <type> change
```

## Records File Format

The `--records-file` option (used with create, add-records, remove-records, set-records) accepts a JSON file:

```json
[
  {
    "value": "198.51.100.1",
    "comment": "My web server at Hetzner Cloud."
  },
  {
    "value": "198.51.100.2",
    "comment": "My other server at Hetzner Cloud."
  }
]
```
