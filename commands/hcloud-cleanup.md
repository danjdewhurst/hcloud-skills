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
