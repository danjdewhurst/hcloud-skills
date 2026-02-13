# hcloud Plugin Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a Claude Code plugin that gives Claude comprehensive knowledge of all hcloud CLI commands, with slash commands for common workflows and safety hooks for destructive operations.

**Architecture:** Resource-oriented skills (7 skills mapping to hcloud resource domains), 3 slash commands for common workflows, 1 safety hook for destructive operation awareness. Reference docs bundled for on-demand deep lookup.

**Tech Stack:** Claude Code plugin system (markdown skills, commands, hooks), bash scripts for hooks.

---

### Task 1: Scaffold Plugin Structure

**Files:**
- Create: `.claude-plugin/plugin.json`
- Create: `skills/` (directory)
- Create: `commands/` (directory)
- Create: `hooks/` (directory)
- Create: `hooks/scripts/` (directory)
- Create: `scripts/` (directory)

**Step 1: Create plugin manifest**

Create `.claude-plugin/plugin.json`:
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

**Step 2: Create directory structure**

```bash
mkdir -p .claude-plugin skills commands hooks/scripts scripts
```

**Step 3: Commit**

```bash
git add .claude-plugin/plugin.json
git commit -m "feat: scaffold hcloud plugin structure"
```

---

### Task 2: Create hcloud-setup Skill

**Files:**
- Create: `skills/hcloud-setup/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-setup/SKILL.md` with content covering:
- Installation methods (homebrew, binary, go install, docker)
- Shell completion setup (bash, zsh, fish, powershell)
- Context management: `hcloud context create|use|active|list|delete|rename|unset`
- Config management: `hcloud config get|set|unset|remove|list`
- Config file location: `~/.config/hcloud/cli.toml`
- API token setup via Hetzner Cloud Console
- Default SSH key configuration: `hcloud config set default-ssh-keys key1,key2`
- Global flags: `--config`, `--context`, `--debug`, `--debug-file`, `--endpoint`, `--quiet`, `--poll-interval`
- Version check: `hcloud version`
- Output options guide: `--output json|yaml|noheader|columns=...|format='...'`
- Integration with jq/yq for JSON/YAML processing

**Skill description:** "Use when the user needs to install, configure, or set up hcloud CLI, manage contexts/API tokens, configure default settings, set up shell completion, or understand output formatting options."

**Step 2: Commit**

```bash
git add skills/hcloud-setup/
git commit -m "feat: add hcloud-setup skill for installation and configuration"
```

---

### Task 3: Create hcloud-servers Skill

**Files:**
- Create: `skills/hcloud-servers/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-servers/SKILL.md` with content covering:

**Server lifecycle:**
- `hcloud server create --name <name> --type <type> --image <image>` with all flags: `--location`, `--ssh-key`, `--network`, `--firewall`, `--volume`, `--user-data-from-file`, `--label`, `--placement-group`, `--primary-ipv4`, `--primary-ipv6`, `--enable-backup`, `--enable-protection`, `--start-after-create`, `--without-ipv4`, `--without-ipv6`, `--allow-deprecated-image`, `--automount`
- `hcloud server list` with columns: id, name, status, type, ipv4, ipv6, location, datacenter, labels, protection, volumes, private_net, placement_group, backup_window, created, age, rescue_enabled, locked, included_traffic, ingoing_traffic, outgoing_traffic, primary_disk_size
- `hcloud server describe <server>` with output options
- `hcloud server delete <server>...`
- `hcloud server update --name <new-name> <server>`

**Power management:**
- `hcloud server poweron <server>`
- `hcloud server poweroff <server>`
- `hcloud server shutdown <server>` (graceful ACPI, `--wait`, `--wait-timeout`)
- `hcloud server reboot <server>`
- `hcloud server reset <server>` (hard reset)

**Access:**
- `hcloud server ssh <server>` with `--user`, `--port`, `--ipv6`, and passthrough SSH options
- `hcloud server ip <server>` with `--ipv6`
- `hcloud server request-console <server>` (WebSocket VNC)

**Server modifications:**
- `hcloud server change-type [--keep-disk] <server> <server-type>`
- `hcloud server rebuild --image <image> <server>` with `--allow-deprecated-image`, `--user-data-from-file`
- `hcloud server create-image --type <snapshot|backup> <server>` with `--description`, `--label`

**Rescue mode:**
- `hcloud server enable-rescue <server>` with `--ssh-key`, `--type`
- `hcloud server disable-rescue <server>`
- `hcloud server reset-password <server>`

**Backups:**
- `hcloud server enable-backup <server>`
- `hcloud server disable-backup <server>`

**Network attachment:**
- `hcloud server attach-to-network --network <network> <server>` with `--ip`, `--ip-range`, `--alias-ips`
- `hcloud server detach-from-network --network <network> <server>`
- `hcloud server change-alias-ips --network <network> <server>` with `--alias-ips`, `--clear`

**ISO:**
- `hcloud server attach-iso <server> <iso>`
- `hcloud server detach-iso <server>`

**Placement groups:**
- `hcloud server add-to-placement-group --placement-group <group> <server>`
- `hcloud server remove-from-placement-group <server>`
- `hcloud placement-group create --name <name> --type <type>` with `--label`
- `hcloud placement-group list`, `describe`, `delete`

**Labels & protection:**
- `hcloud server add-label [--overwrite] <server> <label>...`
- `hcloud server remove-label <server> (--all | <label>...)`
- `hcloud server enable-protection <server> (delete|rebuild)...`
- `hcloud server disable-protection <server> (delete|rebuild)...`
- `hcloud server set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <server>`

**Server types (read-only):**
- `hcloud server-type list` with columns: name, id, description, cores, cpu_type, architecture, memory, disk, storage_type, category, traffic, deprecated
- `hcloud server-type describe <server-type>`

**Images:**
- `hcloud image list` with `--type`, `--architecture`, columns: name, id, type, os_flavor, os_version, description, architecture, disk_size, image_size, created, age, deprecated, bound_to, status, protection, rapid_deploy, labels, created_from
- `hcloud image describe <image>` with `--architecture`
- `hcloud image delete <image>...`
- `hcloud image update <image>` with `--description`, `--type`
- `hcloud image add-label`, `remove-label`, `enable-protection`, `disable-protection`

**Infrastructure reference:**
- `hcloud location list` with columns: name, id, description, country, city, network_zone, latitude, longitude
- `hcloud location describe <location>`
- `hcloud datacenter list` with columns: name, id, description, location
- `hcloud datacenter describe <datacenter>` (note: datacenters deprecated, use locations)
- `hcloud iso list` with `--architecture`, `--type`, columns: id, name, description, type, architecture
- `hcloud iso describe <iso>`
- `hcloud all list` to list all resources

**Skill description:** "Use when the user needs to create, manage, or operate Hetzner Cloud servers, including power management, SSH access, server types, images, snapshots, backups, rescue mode, placement groups, ISOs, or viewing locations and datacenters."

**Step 2: Commit**

```bash
git add skills/hcloud-servers/
git commit -m "feat: add hcloud-servers skill for compute management"
```

---

### Task 4: Create hcloud-networking Skill

**Files:**
- Create: `skills/hcloud-networking/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-networking/SKILL.md` with content covering:

**Networks:**
- `hcloud network create --name <name> --ip-range <cidr>` with `--label`, `--enable-protection`
- `hcloud network list` with columns: id, name, ip_range, servers, age, created, labels, protection
- `hcloud network describe <network>`
- `hcloud network delete <network>...`
- `hcloud network update --name <name> <network>`
- `hcloud network add-subnet --network-zone <zone> --type <cloud|server|vswitch> <network>` with `--ip-range`, `--vswitch-id`
- `hcloud network remove-subnet --ip-range <cidr> <network>`
- `hcloud network add-route --destination <cidr> --gateway <ip> <network>`
- `hcloud network remove-route --destination <cidr> --gateway <ip> <network>`
- `hcloud network change-ip-range --ip-range <cidr> <network>`
- `hcloud network expose-routes-to-vswitch [--disable] <network>`
- Labels and protection patterns

**Firewalls:**
- `hcloud firewall create --name <name>` with `--rules-file`, `--label`
- `hcloud firewall list` with columns: id, name, rules_count, applied_to_count, age, created, labels
- `hcloud firewall describe <firewall>`
- `hcloud firewall delete <firewall>...`
- `hcloud firewall update --name <name> <firewall>`
- `hcloud firewall add-rule` with `--direction in|out`, `--protocol tcp|udp|icmp|esp|gre`, `--port`, `--source-ips`, `--destination-ips`, `--description`
- `hcloud firewall delete-rule` (same flags as add-rule)
- `hcloud firewall replace-rules --rules-file <file> <firewall>`
- `hcloud firewall apply-to-resource --type server|label_selector <firewall>` with `--server`, `--label-selector`
- `hcloud firewall remove-from-resource` (same flags as apply-to-resource)
- Labels

**Floating IPs:**
- `hcloud floating-ip create --type <ipv4|ipv6> (--home-location <loc> | --server <server>)` with `--name`, `--description`, `--label`, `--enable-protection`
- `hcloud floating-ip list` with columns: id, name, type, ip, server, home, dns, description, age, created, labels, protection, blocked
- `hcloud floating-ip describe <floating-ip>`
- `hcloud floating-ip delete <floating-ip>...`
- `hcloud floating-ip update <floating-ip>` with `--name`, `--description`
- `hcloud floating-ip assign <floating-ip> <server>`
- `hcloud floating-ip unassign <floating-ip>`
- `hcloud floating-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <floating-ip>`
- Protection and labels

**Primary IPs:**
- `hcloud primary-ip create --type <ipv4|ipv6> --name <name>` with `--location`, `--assignee-id`, `--auto-delete`, `--label`, `--enable-protection`
- `hcloud primary-ip list` with columns: id, name, type, ip, assignee, assignee_id, assignee_type, auto_delete, dns, age, created, labels, protection, blocked
- `hcloud primary-ip describe <primary-ip>`
- `hcloud primary-ip delete <primary-ip>...`
- `hcloud primary-ip update <primary-ip>` with `--name`, `--auto-delete`
- `hcloud primary-ip assign --server <server> <primary-ip>`
- `hcloud primary-ip unassign <primary-ip>`
- `hcloud primary-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <primary-ip>`
- Protection and labels

**Load Balancers:**
- `hcloud load-balancer create --name <name> --type <type>` with `--algorithm-type round_robin|least_connections`, `--location`, `--network`, `--network-zone`, `--label`, `--enable-protection`
- `hcloud load-balancer list` with columns: id, name, type, ipv4, ipv6, location, network_zone, health, age, created, labels, protection
- `hcloud load-balancer describe <lb>` with `--expand-targets`
- `hcloud load-balancer delete <lb>...`
- `hcloud load-balancer update --name <name> <lb>`
- `hcloud load-balancer add-service` with `--protocol http|tcp|https`, `--listen-port`, `--destination-port`, `--http-certificates`, `--http-redirect-http`, `--http-sticky-sessions`, `--http-cookie-name`, `--http-cookie-lifetime`, `--proxy-protocol`, and health check flags: `--health-check-protocol`, `--health-check-port`, `--health-check-interval`, `--health-check-timeout`, `--health-check-retries`, `--health-check-http-domain`, `--health-check-http-path`, `--health-check-http-response`, `--health-check-http-status-codes`, `--health-check-http-tls`
- `hcloud load-balancer update-service --listen-port <port> <lb>` (same flags as add-service)
- `hcloud load-balancer delete-service --listen-port <port> <lb>`
- `hcloud load-balancer add-target` with `--server`, `--label-selector`, `--ip`, `--use-private-ip`
- `hcloud load-balancer remove-target` with `--server`, `--label-selector`, `--ip`
- `hcloud load-balancer change-algorithm --algorithm-type <type> <lb>`
- `hcloud load-balancer change-type <lb> <lb-type>`
- `hcloud load-balancer attach-to-network --network <network> <lb>` with `--ip`, `--ip-range`
- `hcloud load-balancer detach-from-network --network <network> <lb>`
- `hcloud load-balancer enable-public-interface <lb>`
- `hcloud load-balancer disable-public-interface <lb>`
- `hcloud load-balancer set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <lb>`
- Protection and labels

**Load Balancer Types:**
- `hcloud load-balancer-type list` with columns: id, name, description, max_connections, max_services, max_targets, max_assigned_certificates
- `hcloud load-balancer-type describe <lb-type>`

**Skill description:** "Use when the user needs to manage Hetzner Cloud networking resources including networks, subnets, routes, firewalls, firewall rules, floating IPs, primary IPs, load balancers, load balancer services and targets, or vSwitch integration."

**Step 2: Commit**

```bash
git add skills/hcloud-networking/
git commit -m "feat: add hcloud-networking skill for network resources"
```

---

### Task 5: Create hcloud-storage Skill

**Files:**
- Create: `skills/hcloud-storage/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-storage/SKILL.md` with content covering:

**Volumes:**
- `hcloud volume create --name <name> --size <gb>` with `--server`, `--location`, `--automount`, `--format ext4|xfs`, `--label`, `--enable-protection`
- `hcloud volume list` with columns: id, name, size, server, location, age, created, labels, protection
- `hcloud volume describe <volume>`
- `hcloud volume delete <volume>...`
- `hcloud volume update --name <name> <volume>`
- `hcloud volume attach --server <server> <volume>` with `--automount`
- `hcloud volume detach <volume>`
- `hcloud volume resize --size <gb> <volume>`
- Protection and labels

**Storage Boxes:**
- `hcloud storage-box list` with columns: id, name, location, disk_size, disk_usage, disk_usage_data, disk_usage_snapshots
- `hcloud storage-box describe <storage-box>`
- `hcloud storage-box update --name <name> <storage-box>`
- `hcloud storage-box change-type <storage-box> <storage-box-type>`
- `hcloud storage-box update-access-settings <storage-box>` with `--enable-samba`, `--enable-ssh`, `--enable-webdav`, `--reachable-externally`
- `hcloud storage-box reset-password <storage-box>`
- Labels

**Storage Box Subaccounts:**
- `hcloud storage-box subaccount create --password <pw> --home-directory <dir> <storage-box>` with `--name`, `--description`, `--enable-samba`, `--enable-ssh`, `--enable-webdav`, `--reachable-externally`, `--readonly`, `--label`
- `hcloud storage-box subaccount list <storage-box>` with columns: id, name, username, description, home_directory, age, created, labels, server
- `hcloud storage-box subaccount describe <storage-box> <subaccount>`
- `hcloud storage-box subaccount delete <storage-box> <subaccount>...`
- `hcloud storage-box subaccount update <storage-box> <subaccount>` with `--name`, `--description`
- `hcloud storage-box subaccount update-access-settings <storage-box> <subaccount>` with `--enable-samba`, `--enable-ssh`, `--enable-webdav`, `--reachable-externally`, `--readonly`
- `hcloud storage-box subaccount reset-password <storage-box> <subaccount>`
- Labels

**Storage Box Snapshots:**
- `hcloud storage-box snapshot create <storage-box>` with `--description`, `--label`
- `hcloud storage-box snapshot list <storage-box>` with columns: id, description, disk_usage, age, created, labels
- `hcloud storage-box snapshot describe <storage-box> <snapshot>`
- `hcloud storage-box snapshot delete <storage-box> <snapshot>...`
- `hcloud storage-box snapshot update <storage-box> <snapshot>` with `--description`
- `hcloud storage-box rollback-snapshot <storage-box> <snapshot>`
- Labels

**Storage Box Types:**
- `hcloud storage-box-type list` with columns: id, name, description, disk_size
- `hcloud storage-box-type describe <type>`

**Skill description:** "Use when the user needs to manage Hetzner Cloud storage including volumes (block storage), storage boxes, storage box subaccounts, storage box snapshots, or storage box types."

**Step 2: Commit**

```bash
git add skills/hcloud-storage/
git commit -m "feat: add hcloud-storage skill for volumes and storage boxes"
```

---

### Task 6: Create hcloud-dns Skill

**Files:**
- Create: `skills/hcloud-dns/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-dns/SKILL.md` with content covering:

**Zones:**
- `hcloud zone create --name <domain> --ttl <seconds>` with `--label`, `--enable-protection`
- `hcloud zone list` with columns: id, name, status, ttl, ns, age, created, labels, protection, is_secondary
- `hcloud zone describe <zone>`
- `hcloud zone delete <zone>...`
- `hcloud zone update --name <name> <zone>` with `--ttl`
- `hcloud zone export-zonefile <zone>`
- `hcloud zone import-zonefile --zone-file <file> <zone>`
- `hcloud zone change-ttl --ttl <seconds> <zone>`
- `hcloud zone change-primary-nameservers --primary-nameservers <ns> <zone>`
- Protection and labels

**RRSets (DNS Records):**
- `hcloud zone rrset create --zone <zone> --name <name> --type <type> --values <values> --ttl <seconds>`
- `hcloud zone rrset list <zone>` with columns: name, ttl, type, values
- `hcloud zone rrset delete --zone <zone> --name <name> --type <type>`
- `hcloud zone rrset add-records --zone <zone> --name <name> --type <type> --values <values>`
- `hcloud zone rrset remove-records --zone <zone> --name <name> --type <type> --values <values>`
- `hcloud zone rrset set-records --zone <zone> --name <name> --type <type> --values <values> --ttl <seconds>`

Common DNS record types: A, AAAA, CNAME, MX, TXT, SRV, NS, SOA, CAA

**Skill description:** "Use when the user needs to manage Hetzner DNS zones, DNS records (RRSets), zone files, TTL configuration, nameservers, or any DNS-related operations."

**Step 2: Commit**

```bash
git add skills/hcloud-dns/
git commit -m "feat: add hcloud-dns skill for zone and record management"
```

---

### Task 7: Create hcloud-security Skill

**Files:**
- Create: `skills/hcloud-security/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-security/SKILL.md` with content covering:

**SSH Keys:**
- `hcloud ssh-key create --name <name> --public-key-from-file <file>` with `--public-key`, `--label`
- `hcloud ssh-key list` with columns: id, name, fingerprint, age, created, labels
- `hcloud ssh-key describe <ssh-key>`
- `hcloud ssh-key delete <ssh-key>...`
- `hcloud ssh-key update --name <name> <ssh-key>`
- Labels

**Certificates:**
- `hcloud certificate create --name <name> --type uploaded --cert-file <file> --key-file <file>` for uploaded certs
- `hcloud certificate create --name <name> --type managed --domain <domain>` for managed certs (with `--domain` repeatable)
- `hcloud certificate list` with columns: id, name, type, domain_names, not_valid_after, age, created, labels
- `hcloud certificate describe <cert>`
- `hcloud certificate delete <cert>...`
- `hcloud certificate update --name <name> <cert>`
- Labels

**Cross-resource protection patterns:**
- Server: `enable-protection <server> delete rebuild`
- Network/Volume/Floating IP/Primary IP/Load Balancer/Image/Zone: `enable-protection <resource> delete`
- Protection prevents accidental deletion (and rebuild for servers)

**Cross-resource reverse DNS:**
- Server: `hcloud server set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <server>`
- Floating IP: `hcloud floating-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <floating-ip>`
- Primary IP: `hcloud primary-ip set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <primary-ip>`
- Load Balancer: `hcloud load-balancer set-rdns [--ip <ip>] (--hostname <hostname> | --reset) <lb>`

**Cross-resource label patterns:**
- All managed resources support: `add-label [--overwrite] <resource> <label>...`
- All managed resources support: `remove-label <resource> (--all | <label>...)`
- Label selectors for filtering: `-l key=value` on list commands
- Labels used for firewall targeting: `--type label_selector --label-selector <selector>`

**Skill description:** "Use when the user needs to manage SSH keys, TLS/SSL certificates (uploaded or managed), resource protection, reverse DNS, or labels across Hetzner Cloud resources."

**Step 2: Commit**

```bash
git add skills/hcloud-security/
git commit -m "feat: add hcloud-security skill for keys, certs, and protection"
```

---

### Task 8: Create hcloud-reference Skill

**Files:**
- Create: `skills/hcloud-reference/SKILL.md`

**Step 1: Write the skill**

Create `skills/hcloud-reference/SKILL.md` that serves as an index to the bundled reference docs. Content:

- Explanation that full reference docs are bundled at `${CLAUDE_PLUGIN_ROOT}/docs/reference/manual/`
- File naming pattern: `hcloud_<resource>_<subcommand>.md` (e.g., `hcloud_server_create.md`)
- Index of all resource types and their available subcommands
- Instructions: "Read the specific file for detailed flag documentation when the other skills don't have enough detail"
- Tutorials available at `${CLAUDE_PLUGIN_ROOT}/docs/tutorials/`
- Guides available at `${CLAUDE_PLUGIN_ROOT}/docs/guides/`

**Skill description:** "Use when the user needs detailed hcloud CLI reference documentation beyond what the focused skills provide, or when looking up obscure commands, flags, or advanced usage patterns. This skill provides an index to the full bundled reference manual."

**Step 2: Commit**

```bash
git add skills/hcloud-reference/
git commit -m "feat: add hcloud-reference skill for deep doc lookups"
```

---

### Task 9: Create /hcloud-status Command

**Files:**
- Create: `commands/hcloud-status.md`

**Step 1: Write the command**

Create `commands/hcloud-status.md`:

```markdown
---
name: hcloud-status
description: Show overview of all Hetzner Cloud resources in the current context
---

Show a comprehensive overview of the current Hetzner Cloud infrastructure.

## Steps

1. Show the active context:
   ```
   hcloud context active
   ```

2. List all resources using individual commands for a clear summary:
   - `hcloud server list`
   - `hcloud network list`
   - `hcloud firewall list`
   - `hcloud volume list`
   - `hcloud floating-ip list`
   - `hcloud primary-ip list`
   - `hcloud load-balancer list`
   - `hcloud ssh-key list`
   - `hcloud certificate list`
   - `hcloud placement-group list`
   - `hcloud zone list`
   - `hcloud storage-box list`

3. Present a concise summary highlighting:
   - Total resource counts per type (skip types with zero resources)
   - Servers that are powered off or in error state
   - Unattached volumes
   - Unassigned floating IPs or primary IPs
   - Any resources with protection enabled
   - Any notable states or warnings

Run all list commands and present the summary. Skip resource types that return empty results.
```

**Step 2: Commit**

```bash
git add commands/hcloud-status.md
git commit -m "feat: add /hcloud-status command for infrastructure overview"
```

---

### Task 10: Create /hcloud-deploy Command

**Files:**
- Create: `commands/hcloud-deploy.md`

**Step 1: Write the command**

Create `commands/hcloud-deploy.md`:

```markdown
---
name: hcloud-deploy
description: Guided interactive server deployment on Hetzner Cloud
---

Guide the user through deploying a new server on Hetzner Cloud.

## Steps

1. **Verify context**: Run `hcloud context active` to confirm which project we're deploying to. If no context is active, help the user set one up.

2. **Gather requirements**: Ask the user what they need:
   - What is this server for? (web server, database, development, etc.)
   - Any specific OS preference?
   - Any size/performance requirements?

3. **Select server type**: Run `hcloud server-type list` and recommend an appropriate type based on requirements. Show relevant options with pricing context from the type description.

4. **Select image**: Run `hcloud image list --type system` (and `--type app` if relevant) and recommend an appropriate image.

5. **Select location**: Run `hcloud location list` and let the user choose or recommend based on their region.

6. **SSH key**: Run `hcloud ssh-key list` to check existing keys. If none exist, help create one with `hcloud ssh-key create`.

7. **Networking** (optional): Ask if they need the server attached to a network or firewall. If yes, list available networks/firewalls.

8. **Deploy**: Construct and run the `hcloud server create` command with all selected options. Include `--ssh-key` for secure access.

9. **Verify**: Run `hcloud server describe <server>` to confirm deployment. Show the server IP and SSH connection command.

10. **Post-deploy** (optional): Ask if they want to:
    - Enable backups
    - Enable protection
    - Add labels
    - SSH into the server
```

**Step 2: Commit**

```bash
git add commands/hcloud-deploy.md
git commit -m "feat: add /hcloud-deploy command for guided server deployment"
```

---

### Task 11: Create /hcloud-cleanup Command

**Files:**
- Create: `commands/hcloud-cleanup.md`

**Step 1: Write the command**

Create `commands/hcloud-cleanup.md`:

```markdown
---
name: hcloud-cleanup
description: Find and clean up unused or orphaned Hetzner Cloud resources
---

Scan for unused or orphaned resources and help clean them up.

## Steps

1. **Show context**: Run `hcloud context active` to confirm scope.

2. **Scan for unused resources** by running these commands:

   a. **Unattached volumes**: Run `hcloud volume list -o json` and filter for volumes where server is null/empty.

   b. **Unassigned floating IPs**: Run `hcloud floating-ip list -o json` and filter for IPs where server is null/empty.

   c. **Unassigned primary IPs**: Run `hcloud primary-ip list -o json` and filter for IPs where assignee is null/empty.

   d. **Powered-off servers**: Run `hcloud server list --status off` to find servers that may be forgotten.

   e. **Empty networks**: Run `hcloud network list -o json` and filter for networks with no servers attached.

   f. **Unused SSH keys**: Run `hcloud ssh-key list` and note any that may not be in use (can't be determined automatically, but list them for review).

   g. **Orphaned snapshots**: Run `hcloud image list --type snapshot` to review old snapshots.

3. **Present findings**: Show a categorized summary of potentially unused resources with their details (name, ID, age, size where applicable).

4. **Clean up**: For each category with findings, ask if the user wants to delete them. Process deletions one category at a time, confirming before each batch.

5. **Summary**: Show what was cleaned up and what remains.

Important: Always check for protection before attempting deletion. If a resource has protection enabled, note this and skip it unless the user explicitly asks to remove protection first.
```

**Step 2: Commit**

```bash
git add commands/hcloud-cleanup.md
git commit -m "feat: add /hcloud-cleanup command for resource cleanup"
```

---

### Task 12: Create Safety Hook

**Files:**
- Create: `hooks/hooks.json`
- Create: `hooks/scripts/hcloud-safety.sh`

**Step 1: Write the hook script**

Create `hooks/scripts/hcloud-safety.sh`:

```bash
#!/bin/bash

# hcloud safety hook - warns Claude about destructive hcloud operations
# This is a PreToolUse hook for Bash commands

# Read the tool input from stdin
INPUT=$(cat)

# Extract the command being run
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command or not an hcloud command, allow silently
if [ -z "$COMMAND" ] || ! echo "$COMMAND" | grep -q "hcloud"; then
  exit 0
fi

# Check for destructive operations
DESTRUCTIVE_PATTERNS=(
  "hcloud.*delete"
  "hcloud.*disable-protection"
  "hcloud.*poweroff"
  "hcloud.*shutdown"
  "hcloud.*reset[^-]"
  "hcloud.*remove-from"
  "hcloud.*remove-subnet"
  "hcloud.*remove-route"
  "hcloud.*remove-target"
  "hcloud.*delete-rule"
  "hcloud.*delete-service"
  "hcloud.*replace-rules"
  "hcloud.*remove-from-resource"
  "hcloud.*disable-backup"
  "hcloud.*disable-public-interface"
  "hcloud.*rollback-snapshot"
)

for PATTERN in "${DESTRUCTIVE_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$PATTERN"; then
    # Extract the specific destructive action for the warning
    ACTION=$(echo "$COMMAND" | grep -oE "(delete|disable-protection|poweroff|shutdown|reset|remove-from|remove-subnet|remove-route|remove-target|delete-rule|delete-service|replace-rules|remove-from-resource|disable-backup|disable-public-interface|rollback-snapshot)" | head -1)

    echo "WARN: This hcloud command performs a destructive operation ($ACTION). Ensure the user is aware this will modify or remove cloud resources."
    exit 0
  fi
done

# Non-destructive hcloud command, allow silently
exit 0
```

**Step 2: Make script executable**

```bash
chmod +x hooks/scripts/hcloud-safety.sh
```

**Step 3: Write hooks.json**

Create `hooks/hooks.json`:

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/scripts/hcloud-safety.sh",
          "timeout": 5
        }
      ]
    }
  ]
}
```

**Step 4: Commit**

```bash
git add hooks/
git commit -m "feat: add safety hook for destructive hcloud operations"
```

---

### Task 13: Final Validation & Documentation

**Files:**
- Verify: all skills, commands, hooks exist and are correctly structured
- Create: `CLAUDE.md` (plugin-level instructions if needed)

**Step 1: Verify plugin structure**

```bash
find . -name "*.md" -path "*/skills/*" -o -name "*.md" -path "*/commands/*" | sort
ls -la .claude-plugin/plugin.json hooks/hooks.json hooks/scripts/hcloud-safety.sh
```

Verify:
- 7 SKILL.md files exist
- 3 command .md files exist
- hooks.json and hcloud-safety.sh exist
- plugin.json is valid JSON

**Step 2: Run plugin validator**

Use the plugin-dev:plugin-validator agent to validate the complete plugin structure.

**Step 3: Final commit if any fixes needed**

```bash
git add -A
git commit -m "chore: finalize plugin structure and validation"
```
