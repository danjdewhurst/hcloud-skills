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
