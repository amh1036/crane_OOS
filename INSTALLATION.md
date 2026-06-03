# CRANE Installation Guide

A clear, step-by-step installation guide for **Linux**, **macOS**, and **Windows**.

---

## Table of Contents

1. [Quick Start (Recommended)](#quick-start)
2. [Detailed Installation by OS](#detailed-installation-by-os)
3. [Pre-Flight Checks](#pre-flight-checks)
4. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before starting, you need:

- **Docker Desktop** (Windows/macOS) **OR** Docker Engine + Docker Compose (Linux)
- **Git** (optional, for manual clone)
- **2+ GB RAM** free
- **5+ GB disk space** free
- **Ports 5173, 8000, 5432** must be available

---

## Quick Start (Recommended)

The fastest way to get CRANE running using our automated installer script.

### Linux & macOS

```bash
# Open Terminal and run:
cd ~/Desktop
curl -fsSL https://raw.githubusercontent.com/cra-norm-engine/crane/main/install.sh | bash
```

**Or, review the script before running:**

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/cra-norm-engine/crane/main/install.sh -o install.sh

# Review what it does
cat install.sh

# Run it (only if you trust it)
bash install.sh
```

### Windows (PowerShell)

Open **PowerShell** and run:

```powershell
cd $HOME\Desktop
irm https://raw.githubusercontent.com/cra-norm-engine/crane/main/install.ps1 | iex
```

**Or, review the script first:**

```powershell
# Download the script
irm https://raw.githubusercontent.com/cra-norm-engine/crane/main/install.ps1 -OutFile install.ps1

# Review what it does
Get-Content install.ps1

# Run it (only if you trust it)
.\install.ps1
```

---

## What the installer does

The scripts (`install.sh` / `install.ps1`) automate these steps:

1. ✅ Check if Docker is installed and running
2. ✅ Download CRANE repository
3. ✅ Generate secure secrets (database password, backend secret key)
4. ✅ Create `.env` configuration file
5. ✅ Start all Docker containers
6. ✅ Wait for services to be ready (2-5 minutes)

**After it completes, you'll see:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CRANE is ready!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  App:      http://localhost:5173
  API docs: http://localhost:8000/docs

  Default login:
    Email:    admin@example.com
    Password: admin1234

  You will be prompted to change the password on first login.

  To stop:    docker compose down
  To restart: docker compose up -d
  Logs:       docker compose logs -f
```

**Open your browser and go to:** `http://localhost:5173`

---

## Detailed Installation by OS

If the quick start script doesn't work, or you prefer manual setup, follow the steps for your OS.

### Linux Installation

#### 1. Install Docker Engine

**Ubuntu / Debian:**

```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
```

**Other Linux distributions:** See [Docker installation guide](https://docs.docker.com/engine/install/)

#### 2. Start Docker and add your user to the docker group

```bash
# Start Docker daemon
sudo systemctl start docker

# Add your user to docker group (so you don't need sudo)
sudo usermod -aG docker $USER

# Apply the group change (log out and back in, or run:)
newgrp docker
```

Verify Docker is working:

```bash
docker run hello-world
```

#### 3. Clone CRANE

```bash
# Clone the repository
git clone https://github.com/cra-norm-engine/crane.git
cd crane
```

Or download as ZIP if you don't have Git:

```bash
# Download the zip
wget https://github.com/cra-norm-engine/crane/archive/refs/heads/main.zip
unzip main.zip
cd crane-main
```

#### 4. Configure .env

```bash
# Copy the example configuration
cp .env.example .env

# Edit .env with your preferred editor (nano, vim, etc.)
nano .env
```

**Required values to set:**
- `POSTGRES_PASSWORD` — use `openssl rand -hex 32` to generate a strong value
- `BACKEND_SECRET_KEY` — use `openssl rand -hex 32` to generate a strong value

**Generate the values:**

```bash
# Run this twice to get two 64-character hex strings
openssl rand -hex 32
```

Example:

```bash
# Terminal output:
# 8f3d4e2a...  <- Copy this into POSTGRES_PASSWORD
# 9a4b2c1e...  <- Copy this into BACKEND_SECRET_KEY
```

#### 5. Start CRANE

```bash
docker compose up -d
```

**First run takes 2-5 minutes.** Monitor progress:

```bash
docker compose logs -f backend
```

Wait for the message: `"Backend is ready"` or similar.

#### 6. Access CRANE

- **App:** `http://localhost:5173`
- **API Docs:** `http://localhost:8000/docs`
- **Default Email:** `admin@example.com`
- **Default Password:** `admin1234`

---

### macOS Installation

#### 1. Install Docker Desktop

Go to [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/).

Download the appropriate version:
- **Apple Silicon (M1/M2/M3):** Download the ARM64 version
- **Intel Macs:** Download the Intel x86_64 version

#### 2. Start Docker Desktop

1. Open **Applications** folder
2. Double-click **Docker.app**
3. Wait for Docker menu icon to appear in the top-right corner
4. Verify it's running: open Terminal and run:

```bash
docker run hello-world
```

#### 3. Clone CRANE

```bash
# Clone the repository
git clone https://github.com/cra-norm-engine/crane.git
cd crane
```

Or download as ZIP:

```bash
# Using curl
curl -L https://github.com/cra-norm-engine/crane/archive/refs/heads/main.zip -o crane.zip
unzip crane.zip
cd crane-main
```

#### 4. Configure .env

```bash
# Copy the example configuration
cp .env.example .env

# Edit with your preferred editor (nano, vim, etc.)
nano .env
```

**Generate required values:**

```bash
# Run this twice to get two secure values
openssl rand -hex 32
```

Set these in `.env`:
- `POSTGRES_PASSWORD` — first generated value
- `BACKEND_SECRET_KEY` — second generated value

#### 5. Start CRANE

```bash
docker compose up -d
```

Monitor the startup:

```bash
docker compose logs -f backend
```

#### 6. Access CRANE

- **App:** `http://localhost:5173`
- **API Docs:** `http://localhost:8000/docs`
- **Default Email:** `admin@example.com`
- **Default Password:** `admin1234`

---

### Windows Installation

#### 1. Install Docker Desktop for Windows

1. Go to [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
2. Download **Docker Desktop installer**
3. Run the installer and follow the prompts
4. When asked about WSL 2: Choose **WSL 2 backend** (recommended)
5. Restart your computer when prompted

#### 2. Verify Docker is installed

Open **PowerShell** and run:

```powershell
docker run hello-world
```

If it works, you should see: `Hello from Docker!`

#### 3. Clone CRANE

**Option A: Using Git**

```powershell
git clone https://github.com/cra-norm-engine/crane.git
cd crane
```

**Option B: Using Invoke-WebRequest (no Git needed)**

```powershell
# Download the zip
Invoke-WebRequest -Uri "https://github.com/cra-norm-engine/crane/archive/refs/heads/main.zip" -OutFile "crane.zip"

# Extract the zip
Expand-Archive -Path "crane.zip" -DestinationPath "."

# Move into the directory
cd crane-main
```

#### 4. Configure .env

```powershell
# Copy the example
Copy-Item ".env.example" ".env"

# Open .env in Notepad (or your preferred editor)
notepad .env
```

**Generate required values:** Open PowerShell and run:

```powershell
# Generate two secure random values
[Convert]::ToHexString([Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
[Convert]::ToHexString([Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
```

Copy each output into your `.env` file:
- First value → `POSTGRES_PASSWORD`
- Second value → `BACKEND_SECRET_KEY`

#### 5. Start CRANE

Open **PowerShell** in the crane directory and run:

```powershell
docker compose up -d
```

Check progress:

```powershell
docker compose logs -f backend
```

#### 6. Access CRANE

- **App:** `http://localhost:5173`
- **API Docs:** `http://localhost:8000/docs`
- **Default Email:** `admin@example.com`
- **Default Password:** `admin1234`

---

## Pre-Flight Checks

Before starting, verify your system is ready:

### Check 1: Docker is installed and running

**Linux & macOS:**

```bash
docker info
```

**Windows (PowerShell):**

```powershell
docker info
```

**Expected output:** Information about your Docker installation (not an error)

---

### Check 2: Docker Compose is available

**All platforms:**

```bash
docker compose version
```

**Expected output:** Something like `Docker Compose version v2.24.0`

If you get `"no such command"`, upgrade Docker.

---

### Check 3: Required ports are available

**Linux & macOS:**

```bash
# Check if ports 5173, 8000, 5432 are free
ss -tlnp | grep -E ':(5173|8000|5432)' || echo "All ports are free!"
```

**Windows (PowerShell):**

```powershell
# Check if ports are in use
netstat -ano | findstr /C:":5173" /C:":8000" /C:":5432"
# If nothing prints, ports are free
```

If ports are in use, either:
1. Stop the service using those ports, **OR**
2. Change the ports in `.env`:

```bash
# Edit .env to use different ports
BACKEND_PORT=8001
FRONTEND_PORT=5174
```

---

### Check 4: Disk space

**Linux & macOS:**

```bash
df -h / | tail -1
```

Look for the "Avail" column. You need **5+ GB free**.

**Windows (PowerShell):**

```powershell
Get-PSDrive C | Select-Object @{Name="Free(GB)"; Expression={[math]::round($_.Free/1GB,2)}}
```

You need **5+ GB free**.

---

## Troubleshooting

### "Cannot connect to Docker daemon"

**Problem:** You see `error during connect: this error may indicate the docker daemon is not running`

**Solution:**

- **Linux:** Start Docker with `sudo systemctl start docker`
- **macOS:** Open Docker.app from Applications
- **Windows:** Start Docker Desktop from Start Menu

---

### Port already in use

**Problem:** `Error: bind: address already in use`

**Solution 1: Find what's using the port**

**Linux & macOS:**

```bash
# Find process on port 8000
sudo lsof -i :8000
```

**Windows (PowerShell):**

```powershell
netstat -ano | findstr ":8000"
```

Then stop that process or service.

**Solution 2: Use different ports**

Edit `.env` and change:

```bash
BACKEND_PORT=8001      # Use 8001 instead of 8000
FRONTEND_PORT=5174     # Use 5174 instead of 5173
POSTGRES_PORT=5433     # Use 5433 instead of 5432
```

Then update the database URL in `.env`:

```bash
BACKEND_DATABASE_URL=postgresql+psycopg://postgres:PASSWORD@postgres:5433/cra_compliance
```

---

### Docker image build fails

**Problem:** `Error: failed to build image`

**Solution:**

1. Make sure Docker has enough disk space (5+ GB)
2. Clean up old Docker images:

```bash
docker system prune -a
```

3. Try starting again:

```bash
docker compose up -d
```

---

### Services won't start / health check fails

**Problem:** Containers stop immediately or show `unhealthy`

**Solution 1: Check the logs**

```bash
# View backend logs
docker compose logs backend

# View database logs
docker compose logs postgres

# View all logs
docker compose logs
```

**Solution 2: Check if ports are actually free**

```bash
# Linux & macOS
ss -tlnp | grep -E ':(5173|8000|5432)'

# Windows
netstat -ano | findstr /C:":5173" /C:":8000" /C:":5432"
```

**Solution 3: Restart everything**

```bash
# Stop everything
docker compose down

# Remove volumes (WARNING: deletes database!)
docker compose down -v

# Start fresh
docker compose up -d
```

---

### Slow startup (>5 minutes)

**Problem:** First run takes a very long time

**This is normal!** The backend downloads the Trivy vulnerability database (~200 MB) on first run.

**Check progress:**

```bash
docker compose logs backend | grep -i trivy
```

Just wait. Subsequent startups will be much faster.

---

### Can't access http://localhost:5173

**Problem:** Browser shows "Can't reach this page" or "connection refused"

**Check 1: Are containers running?**

```bash
docker compose ps
```

You should see:
- `crane-frontend ... running`
- `crane-backend ... running`
- `crane-postgres ... running`

If any are not running, check logs:

```bash
docker compose logs frontend
```

**Check 2: Is port 5173 actually being used?**

**Linux & macOS:**

```bash
sudo lsof -i :5173
```

**Windows (PowerShell):**

```powershell
netstat -ano | findstr ":5173"
```

**Check 3: Try accessing the API instead**

```bash
# If this works, frontend might have a problem
curl http://localhost:8000/api/v1/health
```

---

### "admin@example.com / admin1234" doesn't work

**Problem:** Login fails with invalid credentials

**Possible causes:**

1. The app hasn't finished initializing yet — wait a minute and try again
2. The backend isn't running — check `docker compose logs backend`
3. You modified the `.env` before starting — the defaults won't work

**To reset the database and try again:**

```bash
# WARNING: This deletes all data!
docker compose down -v
docker compose up -d
```

Then wait 2-3 minutes and try again.

---

### Database connection errors

**Problem:** Backend logs show `FATAL: password authentication failed` or similar

**Solution:**

1. Check that `POSTGRES_PASSWORD` in `.env` matches `BACKEND_DATABASE_URL`
2. Verify the password doesn't have special characters (stick to hex values)
3. Stop and restart:

```bash
docker compose down
docker compose up -d
```

---

## Next Steps

Once CRANE is running:

1. **Log in** with `admin@example.com` / `admin1234`
2. **Change your password** (you'll be prompted on first login)
3. **Read the docs:** https://cra-norm-engine.github.io/crane/
4. **Get help:** Open an issue on [GitHub](https://github.com/cra-norm-engine/crane/issues)

---

## Need help?

- **Installation issues?** Check the [Troubleshooting](#troubleshooting) section above
- **General questions?** See the [full documentation](https://cra-norm-engine.github.io/crane/)
- **Bug reports?** Open an issue on [GitHub](https://github.com/cra-norm-engine/crane/issues)
- **Security concerns?** See [SECURITY.md](SECURITY.md)
