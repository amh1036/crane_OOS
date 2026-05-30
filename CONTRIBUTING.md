# Contributing to CRANE

Thank you for your interest in contributing to CRANE — CRA Compliance Tool. This document explains how to get involved.

## Ways to Contribute

- **Report bugs** — open a GitHub issue with steps to reproduce
- **Suggest features** — open a GitHub issue describing the use case
- **Fix bugs** — pick an open issue and submit a pull request
- **Improve documentation** — typos, clarity, missing steps
- **Write tests** — improve coverage for existing services

## Getting Started

### Prerequisites

- Python 3.12+
- Node.js 20+
- Docker and Docker Compose
- PostgreSQL 15+ (or use Docker Compose)

### Local Setup

```bash
# Clone the repository
git clone https://github.com/cra-norm-engine/crane.git
cd crane

# Copy environment template
cp .env.example .env
# Edit .env with your local settings

# Start all services
docker compose up -d

# Or run backend and frontend separately:
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload

cd frontend
npm install
npm run dev
```

### Run Tests

```bash
# Backend
cd backend
pip install -r requirements-dev.txt
pytest app/tests

# Frontend
cd frontend
npm run type-check
npm run lint
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes following the code style below
4. Ensure all tests pass
5. Commit using conventional format: `feat(scope): description`
6. Push and open a pull request against `main`
7. Wait for CI to pass and a maintainer to review

## Code Style

**Backend (Python):**
- Follow PEP 8
- Use `ruff` for linting: `ruff check --fix .`
- Use type annotations on all functions
- Add `logger = logging.getLogger(__name__)` at module level in new services

**Frontend (TypeScript/Vue):**
- Use `<script setup lang="ts">` in all components
- Run `npm run lint` before committing
- Use `useAsyncState()` composable for all async operations — do not create manual loading/error refs

## Commit Message Format

```
type(scope): short description

Optional longer description.
```

Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

Examples:
```
feat(products): add bulk export to CSV
fix(auth): handle expired refresh token gracefully
docs(readme): add Docker Compose quickstart
```

## Reporting Security Issues

Do **not** open a public issue for security vulnerabilities. See [SECURITY.md](SECURITY.md).
