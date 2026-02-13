# hcloud for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blueviolet)](https://docs.anthropic.com/en/docs/claude-code)
[![Hetzner Cloud](https://img.shields.io/badge/Hetzner-Cloud-d50c2d)](https://www.hetzner.com/cloud)

A **Claude Code plugin** that gives Claude full knowledge of the [Hetzner Cloud CLI](https://github.com/hetznercloud/cli) (`hcloud`). Manage your entire Hetzner Cloud infrastructure through natural conversation — servers, networks, DNS, storage, and more.

---

## What's Included

### Skills

Skills activate automatically when Claude detects a relevant task. No manual invocation needed.

| Skill | Coverage |
|-------|----------|
| **hcloud-servers** | Server lifecycle, power management, SSH access, rescue mode, backups, snapshots, images, placement groups, ISOs, locations, datacenters |
| **hcloud-networking** | Networks, subnets, routes, firewalls, floating IPs, primary IPs, load balancers, vSwitch |
| **hcloud-storage** | Volumes (block storage), storage boxes, subaccounts, snapshots |
| **hcloud-dns** | DNS zones, RRSets, zone file import/export, TTL, nameservers |
| **hcloud-security** | SSH keys, TLS certificates (uploaded & managed), protection, reverse DNS, labels |
| **hcloud-setup** | Installation, shell completion, contexts, config, API tokens, output formatting |
| **hcloud-reference** | Full index to 260+ bundled CLI reference pages for deep lookups |

### Slash Commands

| Command | Description |
|---------|-------------|
| `/hcloud-status` | Scan all resource types and present a summary of your infrastructure |
| `/hcloud-deploy` | Guided interactive server deployment with smart defaults |
| `/hcloud-cleanup` | Find orphaned resources (unattached volumes, unassigned IPs, etc.) and clean up |

### Safety Hook

A `PreToolUse` hook monitors all Bash commands for destructive `hcloud` operations — `delete`, `poweroff`, `shutdown`, `reset`, `disable-protection`, and more. When detected, it injects a warning into Claude's context so it confirms the action with you before proceeding.

---

## Installation

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- [hcloud CLI](https://github.com/hetznercloud/cli) installed and configured with at least one context

### Install the Plugin

```bash
claude plugin add danjdewhurst/hcloud-skills
```

That's it. Skills, commands, and the safety hook activate automatically.

### Verify

Open Claude Code and run:

```
/hcloud-status
```

You should see a summary of your Hetzner Cloud resources.

---

## Usage Examples

**Deploy a server:**
> "Spin up an Ubuntu server in Nuremberg for a web app"

**Check infrastructure:**
> `/hcloud-status`

**Network setup:**
> "Create a private network 10.0.0.0/16 with a cloud subnet, then attach my web servers to it"

**DNS management:**
> "Set up DNS for example.com — add A records pointing to my server's IP"

**Load balancing:**
> "Create a load balancer with HTTP health checks targeting my servers labeled role=web"

**Clean up:**
> `/hcloud-cleanup`

---

## What Claude Can Do

With this plugin, Claude has embedded knowledge of **every `hcloud` command, flag, and resource type** — no internet lookup needed. It can:

- Create and manage servers, networks, firewalls, volumes, DNS zones, load balancers, and more
- Handle complex multi-step operations (deploy server + attach network + configure firewall + set DNS)
- Use JSON output and `jq` for programmatic workflows
- Reference the full bundled CLI manual for obscure flags or edge cases
- Warn you before any destructive operation touches your infrastructure

---

## Project Structure

```
hcloud-skills/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/
│   ├── hcloud-servers/      # Compute & server management
│   ├── hcloud-networking/   # Networks, firewalls, IPs, load balancers
│   ├── hcloud-storage/      # Volumes & storage boxes
│   ├── hcloud-dns/          # DNS zones & records
│   ├── hcloud-security/     # SSH keys, certs, protection, labels
│   ├── hcloud-setup/        # Installation & configuration
│   └── hcloud-reference/    # Full CLI reference index
├── commands/
│   ├── hcloud-status.md     # Infrastructure overview
│   ├── hcloud-deploy.md     # Guided deployment
│   └── hcloud-cleanup.md    # Resource cleanup
├── hooks/
│   ├── hooks.json           # Hook configuration
│   └── scripts/
│       └── hcloud-safety.sh # Destructive operation warnings
└── docs/
    ├── reference/manual/    # 260+ CLI reference pages
    ├── tutorials/           # Getting started guides
    └── guides/              # Usage guides
```

---

## Contributing

Contributions are welcome! If you find a missing command, incorrect flag, or want to add a new workflow:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

The skills are markdown files — no build step required.

---

## Acknowledgements

The bundled CLI reference documentation in `docs/` is derived from the [hcloud CLI](https://github.com/hetznercloud/cli) project by [Hetzner Cloud GmbH](https://www.hetzner.com/cloud), used under the [MIT License](docs/LICENSE).

---

## License

[MIT](LICENSE) &copy; [Daniel Dewhurst](https://github.com/danjdewhurst)
