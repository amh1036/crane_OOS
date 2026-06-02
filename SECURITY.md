# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest (`main`) | ✅ Yes |
| Older releases | ❌ No — please upgrade |

## Reporting a Vulnerability

**Please do not open a public GitHub issue for security vulnerabilities.**

Report security issues privately by:

1. Opening a [GitHub Security Advisory](https://github.com/cra-norm-engine/crane/security/advisories/new) (preferred)
2. Or emailing the maintainers directly (see the organisation profile for contact)

### What to include

- Description of the vulnerability
- Steps to reproduce
- Affected component (backend API, frontend, Docker config, etc.)
- Potential impact assessment
- Any suggested fix if you have one

### Response timeline

- **Acknowledgement:** within 72 hours
- **Initial assessment:** within 7 days
- **Fix or mitigation:** within 30 days for critical issues

We will credit reporters in the release notes unless you request anonymity.

## Security Considerations for Self-Hosted Deployments

### Default Credentials

CRANE ships with default credentials for first-time setup:

| Field | Value |
|-------|-------|
| Email | `admin@example.com` |
| Password | `admin1234` |

**Important:** You will be forced to change the default password on first login. The default credentials **cannot be used** to log in after the first password change.

### Essential Configuration

When deploying CRANE in production, you **must** configure:

- **`BACKEND_SECRET_KEY`** — Generate a strong, random value (minimum 32 characters)
  ```bash
  openssl rand -hex 32
  ```
- **`POSTGRES_PASSWORD`** — Use a strong, unique password (minimum 32 characters)
  ```bash
  openssl rand -hex 32
  ```
- **`BACKEND_DEBUG=false`** — Always disable debug mode in production
- **`BACKEND_ENVIRONMENT=production`** — Set to production
- **`BACKEND_CORS_ORIGINS`** — Configure for your domain (e.g., `https://compliance.example.com`)
- **Reverse proxy with TLS** — Never expose the backend directly to the internet; use nginx, Caddy, or similar with HTTPS
- **Database port restriction** — Use `docker-compose.prod.yml` which binds the database to localhost only

### Secret Rotation

CRANE uses two types of secrets:

#### Application Secrets (`BACKEND_SECRET_KEY`)

Used for signing authentication tokens and session data.

**To rotate `BACKEND_SECRET_KEY`:**

1. Generate a new key: `openssl rand -hex 32`
2. Update `.env` with the new key
3. Restart the backend: `docker compose restart backend`
4. All existing sessions and tokens will become invalid; users must log in again

#### Database Credentials (`POSTGRES_PASSWORD`)

Used to connect to PostgreSQL.

**To rotate `POSTGRES_PASSWORD`:**

1. Generate a new password: `openssl rand -hex 32`
2. Connect to PostgreSQL as the superuser and update the password:
   ```sql
   ALTER USER postgres WITH PASSWORD 'new_password';
   ```
3. Update `.env` with the new password
4. Restart the backend: `docker compose restart backend`

### Additional Hardening

- **Regularly apply updates** — Monitor GitHub releases and pull security updates promptly
- **Network isolation** — If possible, run CRANE on an isolated network segment; limit access to trusted IPs
- **Backup strategy** — Regularly back up the PostgreSQL database and any uploaded files (`backend/uploads/`)
- **Log monitoring** — Monitor application and database logs for suspicious activity
- **Access control** — Use LDAP/Active Directory integration (if available) to centralize identity management
- **Audit trail** — Regularly review the audit log in the CRANE UI for unauthorized actions

See `docker-compose.prod.yml`, `.env.example`, and [Deployment Guide](../docs/DEPLOY.md) for all configurable settings.
