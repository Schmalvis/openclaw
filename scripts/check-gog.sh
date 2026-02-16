#!/bin/bash
# scripts/check-gog.sh
# Startup health check: verify gog (Google Workspace CLI) is installed
# If missing, attempt installation via Homebrew
# Non-blocking: continues even if installation fails

set +e  # Don't exit on error

echo "🔍 Checking gog (Google Workspace CLI)..."

if command -v gog &> /dev/null; then
  echo "✅ gog is already installed at: $(which gog)"
  exit 0
fi

echo "⚠️  gog not found. Attempting installation via Homebrew..."

export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

if command -v brew &> /dev/null; then
  if brew install steipete/tap/gogcli 2>&1; then
    echo "✅ gog installed successfully at startup"
    exit 0
  else
    echo "⚠️  gog installation failed (tap may be unavailable)"
    echo "💡 This is optional. System will continue normally."
    exit 0
  fi
else
  echo "⚠️  Homebrew not found. Skipping gog installation."
  echo "💡 This is optional. System will continue normally."
  exit 0
fi
