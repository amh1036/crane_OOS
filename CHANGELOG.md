# Changelog

All notable changes to CRANE — CRA Norm Engine are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Security
- Add Developer Certificate of Origin (DCO) enforcement for all contributions
- Improve install script trustworthiness with explicit instructions to review before execution
- Add production Docker Compose configuration (`docker-compose.prod.yml`) with hardened defaults
- Pin Trivy version in Dockerfile to enable reproducible builds and reduce supply-chain risk
- Backend container now runs as non-root user (`crane`) for improved security isolation

### Changed
- **BREAKING:** `.env.example` now uses production-safe defaults (`DEBUG=false`, `ENVIRONMENT=production`)
- Update maturity badge to `beta` and clarify production readiness in README
- Demote curl-to-bash as primary installation method; git clone is now recommended
- Improve documentation on first-time setup, secret rotation, and deployment procedures

### Fixed
- Fix: `start.sh` hardcoded port `10000` instead of respecting `BACKEND_PORT` environment variable
- Update `.env.example` defaults to prevent accidental deployment with development settings

### Added
- Add GitHub Actions workflows for CI (lint, test, build) and automated releases
- Add GitHub community files (issue templates, pull request template, CODEOWNERS, FUNDING.yml)
- Comprehensive production deployment guide with security hardening checklist
- Documentation on secret key rotation (`BACKEND_SECRET_KEY`, `POSTGRES_PASSWORD`)
- Resource limits in production Docker Compose for CPU and memory

### Documentation
- Expand security policy with credential management and rotation procedures
- Document default credentials (`admin@example.com`) and mandatory first-login password change
- Add deployment guide covering production setup, TLS, reverse proxy, backup, and monitoring
- Clarify which values in `.env.example` are required and must be customized

## [0.1.0] - 2026-06-02

### Added
- Initial public release of CRANE
- Product registry with version and release tracking
- SBOM analysis and quality scoring (CycloneDX format)
- Vulnerability management with CVE tracking and EPSS scoring
- Release gates with structured readiness checklist
- CRA Annex I requirements coverage matrix
- Audit trail with immutable, timestamped action log
- Multi-user support with role-based access control (RBAC)
- LDAP/Active Directory integration
- Technical documentation export (PDF, MD)
- Self-hosted deployment with Docker Compose
- Vue 3 frontend with real-time dashboard
- FastAPI backend with comprehensive REST API
