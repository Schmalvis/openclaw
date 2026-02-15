#!/bin/bash
# scripts/install-addons.sh
# Install all custom add-ons (Homebrew + npm) for the Docker image.
# This script is called from the Dockerfile during build.
# See ADDONS.md for the source of truth on what should be installed.

set -e

echo "Installing custom add-ons..."

# ===== Homebrew Packages =====
echo "Installing Homebrew packages..."

# Google Workspace CLI
brew install steipete/tap/gogcli

echo "Homebrew packages installed."

# ===== NPM Global Packages =====
echo "Installing npm global packages..."

npm install -g @coinbase/cdp-sdk

echo "npm global packages installed."

echo "All add-ons installed successfully."
