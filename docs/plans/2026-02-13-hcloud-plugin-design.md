# hcloud Claude Code Plugin Design

## Overview

A Claude Code plugin providing skills, commands, and hooks for the Hetzner Cloud CLI (`hcloud`). Enables Claude to manage Hetzner Cloud infrastructure with full knowledge of all hcloud resource types and operations.

**Target audience:** Community/public (open source)
**Autonomy model:** Full autonomy — Claude runs hcloud commands directly, user permission settings gate risky actions
**Scope:** Complete coverage of all hcloud resource types
**Docs strategy:** Hybrid — core commands embedded in skills, full reference manual bundled for on-demand lookup

## Plugin Structure

```
hcloud-skills/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── hcloud-servers/SKILL.md
│   ├── hcloud-networking/SKILL.md
│   ├── hcloud-storage/SKILL.md
│   ├── hcloud-dns/SKILL.md
│   ├── hcloud-security/SKILL.md
│   ├── hcloud-setup/SKILL.md
│   └── hcloud-reference/SKILL.md
├── commands/
│   ├── hcloud-status.md
│   ├── hcloud-deploy.md
│   └── hcloud-cleanup.md
├── hooks/
│   ├── hooks.json
│   └── scripts/
│       └── hcloud-safety.sh
├── docs/
│   ├── reference/manual/...
│   ├── tutorials/...
│   └── guides/...
└── scripts/
```

### Manifest

```json
{
  "name": "hcloud",
  "version": "1.0.0",
  "description": "Hetzner Cloud CLI skills, commands, and safety hooks for Claude Code",
  "author": {
    "name": "Daniel Dewhurst",
    "url": "https://github.com/danjdewhurst"
  },
  "repository": "https://github.com/danjdewhurst/hcloud-skills",
  "license": "MIT",
  "keywords": ["hetzner", "hcloud", "cloud", "infrastructure", "devops"]
}
```

## Skills

### hcloud-servers

**Triggers:** servers, VMs, compute, instances, server types, images, rebuilds, rescue mode, backups, snapshots

**Embedded knowledge:**
- `server create` with all common flags (type, image, location, ssh-keys, user-data, networks, firewalls, labels, volumes)
- Power lifecycle: `poweron`, `poweroff`, `shutdown`, `reboot`, `reset`
- `server ssh`, `server ip`, `request-console`
- `change-type`, `rebuild`, `create-image`
- `enable-rescue`, `disable-rescue`, `reset-password`
- `enable-backup`, `disable-backup`
- `attach-to-network`, `detach-from-network`, `change-alias-ips`
- Placement groups
- Labels and protection patterns
- Output formatting (json, yaml, columns)

### hcloud-networking

**Triggers:** networks, subnets, firewalls, floating IPs, primary IPs, load balancers, routing, vSwitch

**Embedded knowledge:**
- Network create/manage with subnets and routes
- Firewall rules (add-rule, delete-rule, replace-rules, apply-to-resource)
- Floating IP lifecycle and assignment
- Primary IP lifecycle and assignment
- Load balancer setup: services, targets, algorithms, health checks
- Network attachment patterns across resources

### hcloud-storage

**Triggers:** volumes, storage boxes, block storage, disk

**Embedded knowledge:**
- Volume create, attach, detach, resize, protection
- Storage box lifecycle, subaccounts, snapshots, access settings

### hcloud-dns

**Triggers:** DNS, zones, domains, records, nameservers, zone files

**Embedded knowledge:**
- Zone create/delete/list
- RRSet CRUD (create, delete, add-records, remove-records, set-records)
- Zone file import/export
- TTL and nameserver configuration

### hcloud-security

**Triggers:** SSH keys, certificates, TLS/SSL, protection, access

**Embedded knowledge:**
- SSH key create/delete/update
- Certificate create (uploaded and managed), delete, update
- Protection enable/disable patterns across resource types
- Reverse DNS patterns

### hcloud-setup

**Triggers:** hcloud setup, context, config, authentication, API token, installation, shell completion

**Embedded knowledge:**
- Installation methods
- Context create/use/delete workflow
- Config get/set/unset
- Shell completion setup
- Default SSH key configuration

### hcloud-reference

**Triggers:** detailed flag reference, obscure commands, anything not covered by focused skills

**Content:** Index of bundled docs at `${CLAUDE_PLUGIN_ROOT}/docs/reference/manual/` with file path patterns for on-demand lookup.

## Commands

### /hcloud-status

Quick overview of current infrastructure state.
- Shows active context
- Lists resources across all types
- Highlights notable states (powered-off servers, unattached volumes, etc.)

### /hcloud-deploy

Guided interactive server deployment.
- Asks what to deploy
- Lists available server types, images, locations
- Creates resources with sensible defaults
- Verifies deployment and shows connection details

### /hcloud-cleanup

Find and clean up unused/orphaned resources.
- Scans for unattached volumes, unassigned IPs, unused SSH keys, empty networks
- Presents findings
- Executes cleanup with confirmation per resource

## Hooks

### Safety Hook (PreToolUse on Bash)

Inspects Bash commands for hcloud destructive operations (`delete`, `disable-protection`, `remove`, `shutdown`, `poweroff`, `reset`). Returns a warning message into Claude's context about the impact. Does not block execution.

```json
{
  "PreToolUse": [{
    "matcher": "Bash",
    "hooks": [{
      "type": "command",
      "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/scripts/hcloud-safety.sh"
    }]
  }]
}
```
