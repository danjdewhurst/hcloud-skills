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
