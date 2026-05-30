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

When deploying CRANE in production:

- Set a strong `BACKEND_SECRET_KEY` (minimum 32 random characters)
- Use a strong, unique `POSTGRES_PASSWORD`
- Set `BACKEND_DEBUG=false` and `BACKEND_ENVIRONMENT=production`
- Run behind a reverse proxy (nginx, Caddy) with TLS
- Restrict database access to the backend container only
- Regularly apply OS and dependency updates

See `docker-compose.yml` and `.env.example` for all configurable settings.
