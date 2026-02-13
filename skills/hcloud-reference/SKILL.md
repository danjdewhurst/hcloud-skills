---
name: hcloud-reference
description: "Use when the user needs detailed hcloud CLI reference documentation beyond what the focused skills provide, or when looking up obscure commands, flags, or advanced usage patterns. This skill provides an index to the full bundled reference manual."
---

# hcloud CLI Reference Documentation Index

Full reference docs for every hcloud CLI command are bundled with this plugin. Read the specific file for detailed flag documentation when the other skills don't have enough detail.

## Reference Manual

Location: `${CLAUDE_PLUGIN_ROOT}/docs/reference/manual/`

File naming pattern: `hcloud_<resource>_<subcommand>.md` (e.g., `hcloud_server_create.md`)

### Top-Level Commands

| Command | File |
|---------|------|
| `hcloud` | `hcloud.md` |
| `hcloud version` | `hcloud_version.md` |
| `hcloud completion` | `hcloud_completion.md` |

### all

| Subcommand | File |
|------------|------|
| `all` | `hcloud_all.md` |
| `all list` | `hcloud_all_list.md` |

### certificate

| Subcommand | File |
|------------|------|
| `certificate` | `hcloud_certificate.md` |
| `certificate add-label` | `hcloud_certificate_add-label.md` |
| `certificate create` | `hcloud_certificate_create.md` |
| `certificate delete` | `hcloud_certificate_delete.md` |
| `certificate describe` | `hcloud_certificate_describe.md` |
| `certificate list` | `hcloud_certificate_list.md` |
| `certificate remove-label` | `hcloud_certificate_remove-label.md` |
| `certificate retry` | `hcloud_certificate_retry.md` |
| `certificate update` | `hcloud_certificate_update.md` |

### config

| Subcommand | File |
|------------|------|
| `config` | `hcloud_config.md` |
| `config add` | `hcloud_config_add.md` |
| `config get` | `hcloud_config_get.md` |
| `config list` | `hcloud_config_list.md` |
| `config remove` | `hcloud_config_remove.md` |
| `config set` | `hcloud_config_set.md` |
| `config unset` | `hcloud_config_unset.md` |

### context

| Subcommand | File |
|------------|------|
| `context` | `hcloud_context.md` |
| `context active` | `hcloud_context_active.md` |
| `context create` | `hcloud_context_create.md` |
| `context delete` | `hcloud_context_delete.md` |
| `context list` | `hcloud_context_list.md` |
| `context rename` | `hcloud_context_rename.md` |
| `context unset` | `hcloud_context_unset.md` |
| `context use` | `hcloud_context_use.md` |

### datacenter

| Subcommand | File |
|------------|------|
| `datacenter` | `hcloud_datacenter.md` |
| `datacenter describe` | `hcloud_datacenter_describe.md` |
| `datacenter list` | `hcloud_datacenter_list.md` |

### firewall

| Subcommand | File |
|------------|------|
| `firewall` | `hcloud_firewall.md` |
| `firewall add-label` | `hcloud_firewall_add-label.md` |
| `firewall add-rule` | `hcloud_firewall_add-rule.md` |
| `firewall apply-to-resource` | `hcloud_firewall_apply-to-resource.md` |
| `firewall create` | `hcloud_firewall_create.md` |
| `firewall delete` | `hcloud_firewall_delete.md` |
| `firewall delete-rule` | `hcloud_firewall_delete-rule.md` |
| `firewall describe` | `hcloud_firewall_describe.md` |
| `firewall list` | `hcloud_firewall_list.md` |
| `firewall remove-from-resource` | `hcloud_firewall_remove-from-resource.md` |
| `firewall remove-label` | `hcloud_firewall_remove-label.md` |
| `firewall replace-rules` | `hcloud_firewall_replace-rules.md` |
| `firewall update` | `hcloud_firewall_update.md` |

### floating-ip

| Subcommand | File |
|------------|------|
| `floating-ip` | `hcloud_floating-ip.md` |
| `floating-ip add-label` | `hcloud_floating-ip_add-label.md` |
| `floating-ip assign` | `hcloud_floating-ip_assign.md` |
| `floating-ip create` | `hcloud_floating-ip_create.md` |
| `floating-ip delete` | `hcloud_floating-ip_delete.md` |
| `floating-ip describe` | `hcloud_floating-ip_describe.md` |
| `floating-ip disable-protection` | `hcloud_floating-ip_disable-protection.md` |
| `floating-ip enable-protection` | `hcloud_floating-ip_enable-protection.md` |
| `floating-ip list` | `hcloud_floating-ip_list.md` |
| `floating-ip remove-label` | `hcloud_floating-ip_remove-label.md` |
| `floating-ip set-rdns` | `hcloud_floating-ip_set-rdns.md` |
| `floating-ip unassign` | `hcloud_floating-ip_unassign.md` |
| `floating-ip update` | `hcloud_floating-ip_update.md` |

### image

| Subcommand | File |
|------------|------|
| `image` | `hcloud_image.md` |
| `image add-label` | `hcloud_image_add-label.md` |
| `image delete` | `hcloud_image_delete.md` |
| `image describe` | `hcloud_image_describe.md` |
| `image disable-protection` | `hcloud_image_disable-protection.md` |
| `image enable-protection` | `hcloud_image_enable-protection.md` |
| `image list` | `hcloud_image_list.md` |
| `image remove-label` | `hcloud_image_remove-label.md` |
| `image update` | `hcloud_image_update.md` |

### iso

| Subcommand | File |
|------------|------|
| `iso` | `hcloud_iso.md` |
| `iso describe` | `hcloud_iso_describe.md` |
| `iso list` | `hcloud_iso_list.md` |

### load-balancer

| Subcommand | File |
|------------|------|
| `load-balancer` | `hcloud_load-balancer.md` |
| `load-balancer add-label` | `hcloud_load-balancer_add-label.md` |
| `load-balancer add-service` | `hcloud_load-balancer_add-service.md` |
| `load-balancer add-target` | `hcloud_load-balancer_add-target.md` |
| `load-balancer attach-to-network` | `hcloud_load-balancer_attach-to-network.md` |
| `load-balancer change-algorithm` | `hcloud_load-balancer_change-algorithm.md` |
| `load-balancer change-type` | `hcloud_load-balancer_change-type.md` |
| `load-balancer create` | `hcloud_load-balancer_create.md` |
| `load-balancer delete` | `hcloud_load-balancer_delete.md` |
| `load-balancer delete-service` | `hcloud_load-balancer_delete-service.md` |
| `load-balancer describe` | `hcloud_load-balancer_describe.md` |
| `load-balancer detach-from-network` | `hcloud_load-balancer_detach-from-network.md` |
| `load-balancer disable-protection` | `hcloud_load-balancer_disable-protection.md` |
| `load-balancer disable-public-interface` | `hcloud_load-balancer_disable-public-interface.md` |
| `load-balancer enable-protection` | `hcloud_load-balancer_enable-protection.md` |
| `load-balancer enable-public-interface` | `hcloud_load-balancer_enable-public-interface.md` |
| `load-balancer list` | `hcloud_load-balancer_list.md` |
| `load-balancer metrics` | `hcloud_load-balancer_metrics.md` |
| `load-balancer remove-label` | `hcloud_load-balancer_remove-label.md` |
| `load-balancer remove-target` | `hcloud_load-balancer_remove-target.md` |
| `load-balancer set-rdns` | `hcloud_load-balancer_set-rdns.md` |
| `load-balancer update` | `hcloud_load-balancer_update.md` |
| `load-balancer update-service` | `hcloud_load-balancer_update-service.md` |

### load-balancer-type

| Subcommand | File |
|------------|------|
| `load-balancer-type` | `hcloud_load-balancer-type.md` |
| `load-balancer-type describe` | `hcloud_load-balancer-type_describe.md` |
| `load-balancer-type list` | `hcloud_load-balancer-type_list.md` |

### location

| Subcommand | File |
|------------|------|
| `location` | `hcloud_location.md` |
| `location describe` | `hcloud_location_describe.md` |
| `location list` | `hcloud_location_list.md` |

### network

| Subcommand | File |
|------------|------|
| `network` | `hcloud_network.md` |
| `network add-label` | `hcloud_network_add-label.md` |
| `network add-route` | `hcloud_network_add-route.md` |
| `network add-subnet` | `hcloud_network_add-subnet.md` |
| `network change-ip-range` | `hcloud_network_change-ip-range.md` |
| `network create` | `hcloud_network_create.md` |
| `network delete` | `hcloud_network_delete.md` |
| `network describe` | `hcloud_network_describe.md` |
| `network disable-protection` | `hcloud_network_disable-protection.md` |
| `network enable-protection` | `hcloud_network_enable-protection.md` |
| `network expose-routes-to-vswitch` | `hcloud_network_expose-routes-to-vswitch.md` |
| `network list` | `hcloud_network_list.md` |
| `network remove-label` | `hcloud_network_remove-label.md` |
| `network remove-route` | `hcloud_network_remove-route.md` |
| `network remove-subnet` | `hcloud_network_remove-subnet.md` |
| `network update` | `hcloud_network_update.md` |

### placement-group

| Subcommand | File |
|------------|------|
| `placement-group` | `hcloud_placement-group.md` |
| `placement-group add-label` | `hcloud_placement-group_add-label.md` |
| `placement-group create` | `hcloud_placement-group_create.md` |
| `placement-group delete` | `hcloud_placement-group_delete.md` |
| `placement-group describe` | `hcloud_placement-group_describe.md` |
| `placement-group list` | `hcloud_placement-group_list.md` |
| `placement-group remove-label` | `hcloud_placement-group_remove-label.md` |
| `placement-group update` | `hcloud_placement-group_update.md` |

### primary-ip

| Subcommand | File |
|------------|------|
| `primary-ip` | `hcloud_primary-ip.md` |
| `primary-ip add-label` | `hcloud_primary-ip_add-label.md` |
| `primary-ip assign` | `hcloud_primary-ip_assign.md` |
| `primary-ip create` | `hcloud_primary-ip_create.md` |
| `primary-ip delete` | `hcloud_primary-ip_delete.md` |
| `primary-ip describe` | `hcloud_primary-ip_describe.md` |
| `primary-ip disable-protection` | `hcloud_primary-ip_disable-protection.md` |
| `primary-ip enable-protection` | `hcloud_primary-ip_enable-protection.md` |
| `primary-ip list` | `hcloud_primary-ip_list.md` |
| `primary-ip remove-label` | `hcloud_primary-ip_remove-label.md` |
| `primary-ip set-rdns` | `hcloud_primary-ip_set-rdns.md` |
| `primary-ip unassign` | `hcloud_primary-ip_unassign.md` |
| `primary-ip update` | `hcloud_primary-ip_update.md` |

### server

| Subcommand | File |
|------------|------|
| `server` | `hcloud_server.md` |
| `server add-label` | `hcloud_server_add-label.md` |
| `server add-to-placement-group` | `hcloud_server_add-to-placement-group.md` |
| `server attach-iso` | `hcloud_server_attach-iso.md` |
| `server attach-to-network` | `hcloud_server_attach-to-network.md` |
| `server change-alias-ips` | `hcloud_server_change-alias-ips.md` |
| `server change-type` | `hcloud_server_change-type.md` |
| `server create` | `hcloud_server_create.md` |
| `server create-image` | `hcloud_server_create-image.md` |
| `server delete` | `hcloud_server_delete.md` |
| `server describe` | `hcloud_server_describe.md` |
| `server detach-from-network` | `hcloud_server_detach-from-network.md` |
| `server detach-iso` | `hcloud_server_detach-iso.md` |
| `server disable-backup` | `hcloud_server_disable-backup.md` |
| `server disable-protection` | `hcloud_server_disable-protection.md` |
| `server disable-rescue` | `hcloud_server_disable-rescue.md` |
| `server enable-backup` | `hcloud_server_enable-backup.md` |
| `server enable-protection` | `hcloud_server_enable-protection.md` |
| `server enable-rescue` | `hcloud_server_enable-rescue.md` |
| `server ip` | `hcloud_server_ip.md` |
| `server list` | `hcloud_server_list.md` |
| `server metrics` | `hcloud_server_metrics.md` |
| `server poweroff` | `hcloud_server_poweroff.md` |
| `server poweron` | `hcloud_server_poweron.md` |
| `server reboot` | `hcloud_server_reboot.md` |
| `server rebuild` | `hcloud_server_rebuild.md` |
| `server remove-from-placement-group` | `hcloud_server_remove-from-placement-group.md` |
| `server remove-label` | `hcloud_server_remove-label.md` |
| `server request-console` | `hcloud_server_request-console.md` |
| `server reset` | `hcloud_server_reset.md` |
| `server reset-password` | `hcloud_server_reset-password.md` |
| `server set-rdns` | `hcloud_server_set-rdns.md` |
| `server shutdown` | `hcloud_server_shutdown.md` |
| `server ssh` | `hcloud_server_ssh.md` |
| `server update` | `hcloud_server_update.md` |

### server-type

| Subcommand | File |
|------------|------|
| `server-type` | `hcloud_server-type.md` |
| `server-type describe` | `hcloud_server-type_describe.md` |
| `server-type list` | `hcloud_server-type_list.md` |

### ssh-key

| Subcommand | File |
|------------|------|
| `ssh-key` | `hcloud_ssh-key.md` |
| `ssh-key add-label` | `hcloud_ssh-key_add-label.md` |
| `ssh-key create` | `hcloud_ssh-key_create.md` |
| `ssh-key delete` | `hcloud_ssh-key_delete.md` |
| `ssh-key describe` | `hcloud_ssh-key_describe.md` |
| `ssh-key list` | `hcloud_ssh-key_list.md` |
| `ssh-key remove-label` | `hcloud_ssh-key_remove-label.md` |
| `ssh-key update` | `hcloud_ssh-key_update.md` |

### storage-box

| Subcommand | File |
|------------|------|
| `storage-box` | `hcloud_storage-box.md` |
| `storage-box add-label` | `hcloud_storage-box_add-label.md` |
| `storage-box change-type` | `hcloud_storage-box_change-type.md` |
| `storage-box create` | `hcloud_storage-box_create.md` |
| `storage-box delete` | `hcloud_storage-box_delete.md` |
| `storage-box describe` | `hcloud_storage-box_describe.md` |
| `storage-box disable-protection` | `hcloud_storage-box_disable-protection.md` |
| `storage-box disable-snapshot-plan` | `hcloud_storage-box_disable-snapshot-plan.md` |
| `storage-box enable-protection` | `hcloud_storage-box_enable-protection.md` |
| `storage-box enable-snapshot-plan` | `hcloud_storage-box_enable-snapshot-plan.md` |
| `storage-box folders` | `hcloud_storage-box_folders.md` |
| `storage-box list` | `hcloud_storage-box_list.md` |
| `storage-box remove-label` | `hcloud_storage-box_remove-label.md` |
| `storage-box reset-password` | `hcloud_storage-box_reset-password.md` |
| `storage-box rollback-snapshot` | `hcloud_storage-box_rollback-snapshot.md` |
| `storage-box update` | `hcloud_storage-box_update.md` |
| `storage-box update-access-settings` | `hcloud_storage-box_update-access-settings.md` |

### storage-box snapshot

| Subcommand | File |
|------------|------|
| `storage-box snapshot` | `hcloud_storage-box_snapshot.md` |
| `storage-box snapshot add-label` | `hcloud_storage-box_snapshot_add-label.md` |
| `storage-box snapshot create` | `hcloud_storage-box_snapshot_create.md` |
| `storage-box snapshot delete` | `hcloud_storage-box_snapshot_delete.md` |
| `storage-box snapshot describe` | `hcloud_storage-box_snapshot_describe.md` |
| `storage-box snapshot list` | `hcloud_storage-box_snapshot_list.md` |
| `storage-box snapshot remove-label` | `hcloud_storage-box_snapshot_remove-label.md` |
| `storage-box snapshot update` | `hcloud_storage-box_snapshot_update.md` |

### storage-box subaccount

| Subcommand | File |
|------------|------|
| `storage-box subaccount` | `hcloud_storage-box_subaccount.md` |
| `storage-box subaccount change-home-directory` | `hcloud_storage-box_subaccount_change-home-directory.md` |
| `storage-box subaccount create` | `hcloud_storage-box_subaccount_create.md` |
| `storage-box subaccount delete` | `hcloud_storage-box_subaccount_delete.md` |
| `storage-box subaccount describe` | `hcloud_storage-box_subaccount_describe.md` |
| `storage-box subaccount list` | `hcloud_storage-box_subaccount_list.md` |
| `storage-box subaccount reset-password` | `hcloud_storage-box_subaccount_reset-password.md` |
| `storage-box subaccount update` | `hcloud_storage-box_subaccount_update.md` |
| `storage-box subaccount update-access-settings` | `hcloud_storage-box_subaccount_update-access-settings.md` |

### storage-box-type

| Subcommand | File |
|------------|------|
| `storage-box-type` | `hcloud_storage-box-type.md` |
| `storage-box-type describe` | `hcloud_storage-box-type_describe.md` |
| `storage-box-type list` | `hcloud_storage-box-type_list.md` |

### volume

| Subcommand | File |
|------------|------|
| `volume` | `hcloud_volume.md` |
| `volume add-label` | `hcloud_volume_add-label.md` |
| `volume attach` | `hcloud_volume_attach.md` |
| `volume create` | `hcloud_volume_create.md` |
| `volume delete` | `hcloud_volume_delete.md` |
| `volume describe` | `hcloud_volume_describe.md` |
| `volume detach` | `hcloud_volume_detach.md` |
| `volume disable-protection` | `hcloud_volume_disable-protection.md` |
| `volume enable-protection` | `hcloud_volume_enable-protection.md` |
| `volume list` | `hcloud_volume_list.md` |
| `volume remove-label` | `hcloud_volume_remove-label.md` |
| `volume resize` | `hcloud_volume_resize.md` |
| `volume update` | `hcloud_volume_update.md` |

### zone

| Subcommand | File |
|------------|------|
| `zone` | `hcloud_zone.md` |
| `zone add-label` | `hcloud_zone_add-label.md` |
| `zone add-records` | `hcloud_zone_add-records.md` |
| `zone change-primary-nameservers` | `hcloud_zone_change-primary-nameservers.md` |
| `zone change-ttl` | `hcloud_zone_change-ttl.md` |
| `zone create` | `hcloud_zone_create.md` |
| `zone delete` | `hcloud_zone_delete.md` |
| `zone describe` | `hcloud_zone_describe.md` |
| `zone disable-protection` | `hcloud_zone_disable-protection.md` |
| `zone enable-protection` | `hcloud_zone_enable-protection.md` |
| `zone export-zonefile` | `hcloud_zone_export-zonefile.md` |
| `zone import-zonefile` | `hcloud_zone_import-zonefile.md` |
| `zone list` | `hcloud_zone_list.md` |
| `zone remove-label` | `hcloud_zone_remove-label.md` |
| `zone remove-records` | `hcloud_zone_remove-records.md` |
| `zone set-records` | `hcloud_zone_set-records.md` |

### zone rrset

| Subcommand | File |
|------------|------|
| `zone rrset` | `hcloud_zone_rrset.md` |
| `zone rrset add-label` | `hcloud_zone_rrset_add-label.md` |
| `zone rrset add-records` | `hcloud_zone_rrset_add-records.md` |
| `zone rrset change-ttl` | `hcloud_zone_rrset_change-ttl.md` |
| `zone rrset create` | `hcloud_zone_rrset_create.md` |
| `zone rrset delete` | `hcloud_zone_rrset_delete.md` |
| `zone rrset describe` | `hcloud_zone_rrset_describe.md` |
| `zone rrset disable-protection` | `hcloud_zone_rrset_disable-protection.md` |
| `zone rrset enable-protection` | `hcloud_zone_rrset_enable-protection.md` |
| `zone rrset list` | `hcloud_zone_rrset_list.md` |
| `zone rrset remove-label` | `hcloud_zone_rrset_remove-label.md` |
| `zone rrset remove-records` | `hcloud_zone_rrset_remove-records.md` |
| `zone rrset set-records` | `hcloud_zone_rrset_set-records.md` |

## Tutorials

Location: `${CLAUDE_PLUGIN_ROOT}/docs/tutorials/`

| Tutorial | File |
|----------|------|
| Setup the hcloud CLI | `setup-hcloud-cli.md` |
| Creating a server | `create-a-server.md` |

## Guides

Location: `${CLAUDE_PLUGIN_ROOT}/docs/guides/`

| Guide | File |
|-------|------|
| Using output options | `using-output-options.md` |
