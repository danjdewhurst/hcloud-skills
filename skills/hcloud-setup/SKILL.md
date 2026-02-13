---
name: hcloud-setup
description: "Use when the user needs to install, configure, or set up hcloud CLI, manage contexts/API tokens, configure default settings, set up shell completion, or understand output formatting options."
---

# hcloud CLI Setup and Configuration

## Installation

### Manual (GitHub Releases)

Download pre-built binaries from [GitHub releases](https://github.com/hetznercloud/cli/releases). Extract and move the binary to a directory in your `PATH`.

Example for 64-bit Linux:

```bash
curl -sSLO https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz
sudo tar -C /usr/local/bin --no-same-owner -xzf hcloud-linux-amd64.tar.gz hcloud
rm hcloud-linux-amd64.tar.gz
```

### Go

```bash
go install github.com/hetznercloud/cli/cmd/hcloud@latest
```

Note: Binaries built with Go will not have the correct version embedded.

### Homebrew (Linux / macOS)

```bash
brew install hcloud
```

### Windows

WinGet:

```bash
winget install HetznerCloud.CLI
```

Scoop:

```bash
scoop install hcloud
```

Note: The WinGet and Scoop package entries are not maintained by Hetzner.

### Docker

```bash
docker run --rm -e HCLOUD_TOKEN="<token>" hetznercloud/cli:latest <command>
```

To persist configuration, mount the config file:

```bash
docker run --rm -v ~/.config/hcloud/cli.toml:/config.toml hetznercloud/cli:latest <command>
```

Interactive shell:

```bash
docker run -it --rm --entrypoint /bin/sh hetznercloud/cli:latest
```

> Debian-based distributions (using apt) provide outdated versions of the hcloud CLI. Use one of the other installation methods instead.

## Shell Completion

### Bash

Load into current shell:

```bash
source <(hcloud completion bash)
```

Make permanent by adding the line above to `~/.bashrc`.

### Zsh

Generate the completion file:

```bash
mkdir -p ~/.config/hcloud/completion/zsh
hcloud completion zsh > ~/.config/hcloud/completion/zsh/_hcloud
```

Add to `~/.zshrc` (the `fpath` line must come **before** `compinit`):

```bash
fpath+=(~/.config/hcloud/completion/zsh)
# ... anything else that needs to be done before compinit
autoload -Uz compinit; compinit
```

Restart the shell for changes to take effect.

### Fish

Permanent installation:

```bash
hcloud completion fish > ~/.config/fish/completions/hcloud.fish
```

Load into current shell only:

```bash
hcloud completion fish | source
```

### PowerShell

Save completion script:

```powershell
hcloud completion powershell > hcloud.ps1
```

Load into current shell:

```powershell
hcloud completion powershell | Out-String | Invoke-Expression
```

Source the saved file from your PowerShell profile for persistence.

## Context Management

Contexts manage multiple Hetzner Cloud API tokens and per-project configuration.

### Create a context

```bash
hcloud context create <name>
```

Prompts interactively for an API token. To use the `HCLOUD_TOKEN` environment variable instead:

```bash
hcloud context create --token-from-env <name>
```

| Flag | Description |
|------|-------------|
| `--token-from-env` | Use `HCLOUD_TOKEN` from environment without prompting |

### Switch context

```bash
hcloud context use <context>
```

### Show active context

```bash
hcloud context active
```

### List all contexts

```bash
hcloud context list [options]
```

| Flag | Description |
|------|-------------|
| `-o, --output stringArray` | Output options: `noheader\|columns=...` |

Available columns: `active`, `name`.

### Delete a context

```bash
hcloud context delete <context>
```

### Rename a context

```bash
hcloud context rename <context> <name>
```

### Unset active context

```bash
hcloud context unset
```

## Config Management

Configuration file location: `~/.config/hcloud/cli.toml`

### Config hierarchy (highest to lowest priority)

1. Flags
2. Environment variables
3. Configuration file (context)
4. Configuration file (global)
5. Default values

### Set a value

```bash
hcloud config set <key> <value>...
```

| Flag | Description |
|------|-------------|
| `--global` | Set the value globally (for all contexts) |

### Get a value

```bash
hcloud config get <key>
```

| Flag | Description |
|------|-------------|
| `--allow-sensitive` | Allow showing sensitive values |
| `--global` | Get the value globally |

### List configuration

```bash
hcloud config list
```

| Flag | Description |
|------|-------------|
| `-a, --all` | Also show default values |
| `--allow-sensitive` | Allow showing sensitive values |
| `-g, --global` | Only show global values |
| `-o, --output stringArray` | Output options: `noheader\|columns=...\|json\|yaml` |

### Add values to a list

```bash
hcloud config add <key> <value>...
```

| Flag | Description |
|------|-------------|
| `--global` | Set the value globally (for all contexts) |

### Remove values from a list

```bash
hcloud config remove <key> <value>...
```

| Flag | Description |
|------|-------------|
| `--global` | Remove the value(s) globally (for all contexts) |

### Unset a value

```bash
hcloud config unset <key>
```

| Flag | Description |
|------|-------------|
| `--global` | Unset the value globally (for all contexts) |

### Preference keys

These keys can be used with `set`, `unset`, `add`, and `remove`:

| Key | Description | Type | Config key | Env variable |
|-----|-------------|------|------------|--------------|
| `debug` | Enable debug output | boolean | `debug` | `HCLOUD_DEBUG` |
| `debug-file` | File to write debug output to | string | `debug_file` | `HCLOUD_DEBUG_FILE` |
| `default-ssh-keys` | Default SSH Keys for new Servers and Storage Boxes | string list | `default_ssh_keys` | `HCLOUD_DEFAULT_SSH_KEYS` |
| `endpoint` | Hetzner Cloud API endpoint | string | `endpoint` | `HCLOUD_ENDPOINT` |
| `hetzner-endpoint` | Hetzner API endpoint | string | `hetzner_endpoint` | `HETZNER_ENDPOINT` |
| `no-experimental-warnings` | Suppress experimental warnings | boolean | `no_experimental_warnings` | `HCLOUD_NO_EXPERIMENTAL_WARNINGS` |
| `poll-interval` | Polling interval for action progress | duration | `poll_interval` | `HCLOUD_POLL_INTERVAL` |
| `quiet` | Only print error messages | boolean | `quiet` | `HCLOUD_QUIET` |
| `sort.<resource>` | Default sorting for a resource | string list | `sort.<resource>` | `HCLOUD_SORT_<RESOURCE>` |

### Non-preference keys (read-only via config)

| Key | Description | Type | Config key | Env variable |
|-----|-------------|------|------------|--------------|
| `config` | Config file path | string | | `HCLOUD_CONFIG` |
| `context` | Currently active context | string | `active_context` | `HCLOUD_CONTEXT` |
| `token` | Hetzner Cloud API token | string | `token` | `HCLOUD_TOKEN` |

These cannot be modified with `hcloud config set` or `hcloud config unset`, but can be retrieved with `hcloud config get` and `hcloud config list`.

## Global Flags

These flags are inherited by all commands:

| Flag | Description | Default |
|------|-------------|---------|
| `--config string` | Config file path | `~/.config/hcloud/cli.toml` |
| `--context string` | Currently active context | |
| `--debug` | Enable debug output | |
| `--debug-file string` | File to write debug output to | |
| `--endpoint string` | Hetzner Cloud API endpoint | `https://api.hetzner.cloud/v1` |
| `--hetzner-endpoint string` | Hetzner API endpoint | `https://api.hetzner.com/v1` |
| `--no-experimental-warnings` | Suppress experimental warnings | |
| `--poll-interval duration` | Polling interval for action progress | `500ms` |
| `--quiet` | Only print error messages | |

## Output Formatting

### JSON output

Supported by `describe`, `list`, and `create` commands. Lists return an array, describe returns an object.

```bash
hcloud server list --output json
hcloud server describe my-server --output json
```

Use with `jq` for filtering:

```bash
hcloud server list -o json | jq '.[] | .name'
```

### YAML output

Supported by `describe`, `list`, and `create` commands.

```bash
hcloud server list --output yaml
```

Use with `yq` for filtering:

```bash
hcloud server list --output yaml | yq '.[] | .name'
```

### Go template format (describe only)

```bash
hcloud server describe my-server --output format='{{.ServerType.Cores}}'
```

### Table options (list only)

Remove the table header:

```bash
hcloud server list --output noheader
```

Select specific columns:

```bash
hcloud server list --output columns=id,name
```

Combine options:

```bash
hcloud server list --output noheader --output columns=id,name
```

Use `--help` on any list command to see all available columns.

## Other Commands

### Print version

```bash
hcloud version
```

### List all resources

```bash
hcloud all list [options]
```

Lists all resources in the project (Servers, Images, Placement Groups, Primary IPs, ISOs, Volumes, Load Balancers, Floating IPs, Networks, Firewalls, Certificates, SSH Keys, Storage Boxes, Zones). Does not include static/public resources like Locations or public ISOs.

| Flag | Description |
|------|-------------|
| `--paid` | Only list resources that cost money |
| `-l, --selector string` | Selector to filter by labels |
| `-o, --output stringArray` | Output options: `json\|yaml` |
