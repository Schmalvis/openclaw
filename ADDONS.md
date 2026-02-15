# ADDONS.md - Custom Docker Add-ons

**📌 IMPORTANT RULE:** Every time you install anything new (packages, skills, tools, etc.), you MUST update this file AND `scripts/install-addons.sh`. This is the single source of truth for all custom Docker dependencies. Without this, new deployments won't include what you installed.

This file documents all custom system-level and package installs for the Docker image. See `scripts/install-addons.sh` for the actual installation logic.

## NPM Global Packages

- **@coinbase/cdp-sdk** — Coinbase Developer Platform SDK for Node.js

## Homebrew Packages

- **steipete/tap/gogcli** (`gog`) — Google Workspace CLI for Gmail, Calendar, Drive, Contacts, Sheets, Docs

## Adding New Add-ons (DO THIS EVERY TIME)

**Checklist for every new install:**

1. ✅ **Document it here** — Add description to NPM or Homebrew section
2. ✅ **Install command** — Add the install command to `scripts/install-addons.sh`
3. ✅ **Commit both files** — `git add ADDONS.md scripts/install-addons.sh && git commit -m "add: <package-name>"`
4. ✅ **Push to main** — Next deploy will automatically include it

**Without these steps, the package disappears on next redeploy.**

### Examples

**Adding a Homebrew package:**
```bash
# ADDONS.md (Homebrew section)
- **package-name** — Description of what it does

# scripts/install-addons.sh (in the Homebrew section)
brew install package-name

# Then commit & push
```

**Adding an NPM package:**
```bash
# ADDONS.md (NPM section)
- **package-name** — Description of what it does

# scripts/install-addons.sh (in the NPM section)
npm install -g package-name

# Then commit & push
```
