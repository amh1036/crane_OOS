# Release Process

This document describes how to publish a new version of CRANE.

## Versioning

CRANE follows [Semantic Versioning](https://semver.org/):

- `MAJOR` — breaking changes to the API or database schema requiring manual migration steps
- `MINOR` — new features, backwards-compatible
- `PATCH` — bug fixes and security patches

## Steps to Release

### 1. Prepare the release branch

```bash
git checkout main
git pull origin main
git checkout -b release/v1.2.3
```

### 2. Update version and changelog

Update the version in:
- `frontend/package.json` → `"version": "1.2.3"`
- `backend/pyproject.toml` → `version = "1.2.3"`

Update [CHANGELOG.md](CHANGELOG.md):
- Move the `[Unreleased]` section to a new `[1.2.3] - 2026-06-02` section
- Keep the unreleased section at the top for future changes

### 3. Verify everything passes

```bash
# Backend
cd backend
ruff check .
pytest app/tests

# Frontend
cd frontend
npm run type-check
npm run lint
npm run build
```

### 4. Commit and tag

```bash
git add frontend/package.json backend/pyproject.toml
git commit -m "chore: bump version to v1.2.3"
git push origin release/v1.2.3

# Open a PR, get approval, merge to main
# Then tag on main:
git checkout main
git pull origin main
git tag -a v1.2.3 -m "Release v1.2.3"
git push origin v1.2.3
```

### 5. Publish GitHub Release

```bash
gh release create v1.2.3 \
  --title "v1.2.3" \
  --notes "$(cat <<'EOF'
## What's changed

### New features
- ...

### Bug fixes
- ...

### Database migrations
- Run `alembic upgrade head` after pulling this release

## Upgrading

```bash
docker compose pull
docker compose up -d
```
EOF
)"
```

### 6. Build and publish Docker images

```bash
# Backend image
docker build -t ghcr.io/cra-norm-engine/crane-backend:v1.2.3 ./backend
docker push ghcr.io/cra-norm-engine/crane-backend:v1.2.3
docker tag ghcr.io/cra-norm-engine/crane-backend:v1.2.3 ghcr.io/cra-norm-engine/crane-backend:latest
docker push ghcr.io/cra-norm-engine/crane-backend:latest

# Frontend image
docker build -t ghcr.io/cra-norm-engine/crane-frontend:v1.2.3 ./frontend
docker push ghcr.io/cra-norm-engine/crane-frontend:v1.2.3
docker tag ghcr.io/cra-norm-engine/crane-frontend:v1.2.3 ghcr.io/cra-norm-engine/crane-frontend:latest
docker push ghcr.io/cra-norm-engine/crane-frontend:latest
```

**Note:** This requires push access to GitHub Container Registry. Configure [Docker authentication](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) first:

```bash
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

Alternatively, use the GitHub Actions CI workflow (`.github/workflows/release.yml`) which automates this step when a tag is pushed.

## Hotfix Process

For urgent security or critical bug fixes:

```bash
git checkout -b hotfix/v1.2.4 v1.2.3
# make the fix
git commit -m "fix: description of critical fix"
git push origin hotfix/v1.2.4
# PR → merge → tag v1.2.4
```
