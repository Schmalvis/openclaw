#!/bin/bash
# scripts/install-addons.sh
# Install all custom add-ons (Homebrew + npm) for the Docker image.
# This script is called from the Dockerfile during build.
# See ADDONS.md for the source of truth on what should be installed.

set -e

echo "Installing custom add-ons..."

# ===== NPM Global Packages =====
echo "Installing npm global packages..."

# Install to /usr/local so node user can access
# (by default, root's npm goes to /root/.npm which node can't access)
export npm_config_prefix=/usr/local

# Coinbase CDP SDK
echo "→ Installing @coinbase/cdp-sdk..."
if npm install -g @coinbase/cdp-sdk --no-audit --no-fund 2>&1; then
  echo "✓ @coinbase/cdp-sdk installed successfully"
else
  echo "❌ @coinbase/cdp-sdk installation failed"
  exit 1
fi

echo "npm global packages installed."

# ===== Developer Tools =====
echo ""
echo "Installing developer tools..."

# Claude Code (Anthropic AI Coding Assistant)
echo "→ Installing Claude Code..."
if curl -fsSL https://claude.ai/install.sh | bash 2>&1; then
  echo "✓ Claude Code installed successfully"
else
  echo "⚠️  Claude Code installation failed (non-blocking, may require authentication)"
fi

echo "Developer tools installed."

# ===== MCP (Model Context Protocol) Servers =====
echo ""
echo "Installing MCP servers..."

# Filesystem access
echo "→ Installing MCP filesystem server..."
if npm install -g @modelcontextprotocol/server-filesystem --no-audit --no-fund 2>&1; then
  echo "✓ MCP filesystem server installed"
else
  echo "⚠️  MCP filesystem server installation failed (non-blocking)"
fi

# Persistent memory
echo "→ Installing MCP memory server..."
if npm install -g @modelcontextprotocol/server-memory --no-audit --no-fund 2>&1; then
  echo "✓ MCP memory server installed"
else
  echo "⚠️  MCP memory server installation failed (non-blocking)"
fi

# Sequential thinking
echo "→ Installing MCP sequential thinking server..."
if npm install -g @modelcontextprotocol/server-sequential-thinking --no-audit --no-fund 2>&1; then
  echo "✓ MCP sequential thinking server installed"
else
  echo "⚠️  MCP sequential thinking server installation failed (non-blocking)"
fi

echo "MCP servers installed."

echo ""
echo "All add-ons installed successfully."
