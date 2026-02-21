# ADDONS.md - Custom Docker Add-ons

This file documents all custom system-level and package installs for the Docker image. See `scripts/install-addons.sh` for the actual installation logic.

## NPM Global Packages

- **@coinbase/cdp-sdk** — Coinbase Developer Platform SDK for Node.js

## Developer Tools

- **Claude Code** — Official Anthropic AI coding assistant (native binary install)

## MCP (Model Context Protocol) Servers

- **@modelcontextprotocol/server-filesystem** — File system access with secure path restrictions
- **@modelcontextprotocol/server-memory** — Persistent knowledge graph-based memory system
- **@modelcontextprotocol/server-everything** — Reference server with prompts, resources, and tools
- **@modelcontextprotocol/server-sequential-thinking** — Dynamic problem-solving through thought sequences

## Homebrew Packages

- **steipete/tap/gogcli** (`gog`) — Google Workspace CLI for Gmail, Calendar, Drive, Contacts, Sheets, Docs

## Adding New Add-ons

When installing a new add-on:

1. Add an entry to this file (NPM or Homebrew section)
2. Update `scripts/install-addons.sh` with the install command
3. Push to main — the next deploy will include it

This ensures future deployments always have everything.
