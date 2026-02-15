# CREDENTIALS.md - Auth Persistence & Credential Management

**Important:** Credentials persist across container redeploys via host-mounted volume.

## Directory Structure

Host machine (RPi):
```
~/.openclaw/credentials/
├── google-drive-service-account.json    # Google Cloud service account (static)
├── gog/                                 # gog (Google Workspace CLI) tokens
│   ├── config                          # OAuth tokens from `gog auth add`
│   └── state                           # gog session state
└── ...                                 # Other credentials as needed
```

Inside container: `/home/node/.credentials/` (mounted from `~/.openclaw/credentials`)

## Setup

### 1. Ensure credentials directory exists on host

```bash
mkdir -p ~/.openclaw/credentials
```

### 2. Configure docker-compose.yml (already done)

The docker-compose.yml mounts the credentials directory:

```yaml
volumes:
  - ${OPENCLAW_CREDENTIALS_DIR:-~/.openclaw/credentials}:/home/node/.credentials
```

Environment variable `OPENCLAW_CREDENTIALS_DIR` can override the default. If not set, it defaults to `~/.openclaw/credentials`.

### 3. Set up gog (Google Workspace CLI)

**First time setup (inside container):**

```bash
# Get the client_secret.json from Google Cloud Console
# (setup OAuth app if not done yet)

docker-compose exec openclaw-cli gog auth credentials /path/to/client_secret.json

# Add your Google account and approve OAuth
docker-compose exec openclaw-cli gog auth add your-email@gmail.com --services gmail,calendar,drive,contacts,docs,sheets
```

This stores the OAuth tokens in `/home/node/.credentials/gog/config`, which persists on the host.

**After redeploy:**

When the container restarts, gog automatically finds credentials at `~/.openclaw/credentials/gog/` — no re-auth needed!

### 4. Verify credentials are persisted

```bash
# On host
ls -la ~/.openclaw/credentials/

# Inside container
docker-compose exec openclaw-cli ls -la /home/node/.credentials/
```

## Environment Variables

**Inside container (docker-compose.yml):**

- `GOG_HOME` — Points to `/home/node/.credentials` so gog finds its config
- `HOME` — Set to `/home/node` for all user configs

**On host (docker-compose.yml or .env):**

- `OPENCLAW_CREDENTIALS_DIR` — Override default credentials location (default: `~/.openclaw/credentials`)

## Adding More Credentials

When adding new tools/APIs:

1. Decide if credentials should be stored as files or API keys
2. Create subdirectory under `~/.openclaw/credentials/` (e.g., `~/.openclaw/credentials/anthropic/`)
3. Mount it in docker-compose.yml (already done for all of `~/.openclaw/credentials/`)
4. Set environment variables inside container to point to the mounted location

## Security Notes

- **Never commit credentials to git** — `.credentials/` is in `.gitignore`
- **Protect host credentials** — Ensure `~/.openclaw/credentials/` has proper permissions:
  ```bash
  chmod 700 ~/.openclaw/credentials
  ```
- **Rotate secrets regularly** — OAuth tokens should expire; consider re-auth every 90 days
- **Use service accounts where possible** — Less risky than personal OAuth tokens

## Troubleshooting

**gog can't find credentials after redeploy:**
- Check `GOG_HOME` is set to `/home/node/.credentials` in docker-compose.yml
- Verify host mount: `docker-compose exec openclaw-cli ls /home/node/.credentials/`
- Check permissions: `docker-compose exec openclaw-cli ls -la /home/node/.credentials/`

**Permissions issues inside container:**
- Container runs as `node` user (uid 1000)
- Credentials should be readable by node user
- If mount fails, check RPi host permissions on `~/.openclaw/credentials/`
