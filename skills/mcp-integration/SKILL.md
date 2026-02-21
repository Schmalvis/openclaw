---
name: mcp-integration
description: Model Context Protocol (MCP) integration for OpenClaw. Connect to external tools, data sources, and workflows via standardized MCP servers.
homepage: https://modelcontextprotocol.io
---

# MCP Integration

**Model Context Protocol (MCP)** is an open standard for AI applications to connect to external systems.

Think of it like a **USB-C port for AI** — standardized connections to tools, data sources, and workflows.

## What MCP Enables

- Access to **local files, databases, APIs**
- **External tools**: search engines, calculators, code editors
- **Workflows**: specialized prompts, integrations
- **Real-time data**: calendars, email, notifications

## Common MCP Servers

### File System Access
- **filesystem** — Read/write files on your system
- **Built-in**: Enabled by default in Claude Code

### Data & APIs
- **postgres** — PostgreSQL database access
- **sqlite** — SQLite database access
- **web** — Web search and content extraction
- **github** — GitHub repository integration

### Productivity
- **google-calendar** — Calendar and meeting management
- **slack** — Slack workspace integration
- **notion** — Notion database access

### Development
- **git** — Git repository operations
- **docker** — Docker container management
- **bash** — Shell command execution

## Configuration

### Claude Code MCP Setup

Edit `~/.claude/settings.json` or `~/.claude.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "mcp-server-filesystem",
      "args": ["--root", "/home/user/projects"]
    },
    "postgres": {
      "command": "mcp-server-postgres",
      "args": ["--connection", "postgresql://user:pass@localhost/dbname"]
    },
    "web": {
      "command": "mcp-server-web"
    }
  }
}
```

### Per-Project MCP Configuration

Create `.mcp.json` in your project root:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "mcp-server-filesystem",
      "args": ["--root", "."]
    }
  }
}
```

## Installation

### Popular MCP Servers

```bash
# Filesystem (built-in)
# No installation needed

# PostgreSQL
npm install -g @modelcontextprotocol/server-postgres

# SQLite  
npm install -g @modelcontextprotocol/server-sqlite

# GitHub
npm install -g @modelcontextprotocol/server-github

# Web search
npm install -g @modelcontextprotocol/server-web
```

## OpenClaw MCP Integration

### Enable MCP in Claude Code

When using Claude Code with OpenClaw:

1. **Configure MCP servers** in `~/.claude/settings.json`
2. **Start Claude Code** in your project: `claude`
3. **MCP tools available** to Claude Code automatically

### Docker Build Integration

MCP servers can be bundled into the Docker image via `ADDONS.md`:

```markdown
## MCP Servers

- **mcp-server-filesystem** — File system access
- **mcp-server-postgres** — PostgreSQL databases
```

And installed in `scripts/install-addons.sh`:

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

## Examples

### Read/Write Files with MCP
```
Claude: "Edit the README.md file in the current directory"
→ MCP filesystem server handles file operations
→ Claude receives file contents, makes changes
```

### Query Databases with MCP
```
Claude: "How many users signed up last week?"
→ MCP postgres server connects to database
→ Claude receives query results
→ Claude provides analysis
```

### Search the Web with MCP
```
Claude: "Find the latest news on AI"
→ MCP web server performs search
→ Claude receives results and summarizes
```

## Learn More

- **Official MCP Docs**: https://modelcontextprotocol.io
- **Building MCP Servers**: https://modelcontextprotocol.io/docs/develop/build-server
- **Available Servers**: https://github.com/modelcontextprotocol/servers

## Troubleshooting

**MCP server not connecting?**
1. Verify server is installed: `which mcp-server-<name>`
2. Check configuration in `settings.json`
3. View Claude Code logs: `~/.claude/logs/`
4. Test manually: `mcp-server-<name> --help`

**Performance issues?**
- Start with one MCP server
- Add servers incrementally
- Monitor memory usage: `top`

**Security concerns?**
- MCP runs locally by default
- Only grant filesystem access to needed directories
- Use database credentials securely (environment variables)
