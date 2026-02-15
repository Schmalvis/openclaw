# ADDONS.md - Custom Docker Add-ons

This file documents all custom system-level and package installs for the Docker image. See `scripts/install-addons.sh` for the actual installation logic.

## NPM Global Packages

- **@coinbase/cdp-sdk** — Coinbase Developer Platform SDK for Node.js

## Homebrew Packages

- **steipete/tap/gogcli** (`gog`) — Google Workspace CLI for Gmail, Calendar, Drive, Contacts, Sheets, Docs

## Adding New Add-ons

When installing a new add-on:

1. Add an entry to this file (NPM or Homebrew section)
2. Update `scripts/install-addons.sh` with the install command
3. Push to main — the next deploy will include it

This ensures future deployments always have everything.
