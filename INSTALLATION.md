# 🚀 Prompt Airlines CTF - Installation & Setup

## Prerequisites

- **Node.js** 20+ (check: `node --version`)
- **npm** (check: `npm --version`)
- **Internet connection** (for API requests)
- **Terminal/Shell** (bash recommended)

## Installation Methods

### Method 1: Global Install (Recommended)

```bash
# Install Promptfoo globally
npm install -g promptfoo

# Verify installation
promptfoo --version

# Should output: 0.119.6 or later
```

### Method 2: NPX (No Install)

```bash
# Run directly with npx (no installation needed)
npx promptfoo@latest --version

# Run tests with npx
npx promptfoo@latest eval -c prompt-airlines-redteam.yaml
```

### Method 3: Local Development (From Source)

```bash
# If you're in the promptfoo repository
cd /workspace

# Install dependencies
npm install

# Build
npm run build

# Run locally
npm run local -- eval -c prompt-airlines-redteam.yaml
```

## Quick Setup Guide

### Step 1: Install Promptfoo

```bash
npm install -g promptfoo
```

### Step 2: Navigate to Configuration Directory

```bash
cd /workspace
# Or wherever you placed the config files
```

### Step 3: Verify Files Exist

```bash
ls -lh prompt-airlines*

# Expected output:
# prompt-airlines-redteam.yaml
# prompt-airlines-quickstart.md
# prompt-airlines-test.sh
```

### Step 4: Test Installation

```bash
# Test with quick config
promptfoo eval -c prompt-airlines-quick.yaml

# Or use the interactive test runner
bash prompt-airlines-test.sh
```

## Troubleshooting Installation

### Issue: "promptfoo: command not found"

**Solution 1 - Check PATH**:
```bash
# Find npm global bin directory
npm config get prefix

# Add to PATH (Linux/Mac)
echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Add to PATH (Windows)
# Add npm global directory to System Environment Variables
```

**Solution 2 - Use npx**:
```bash
# No installation needed
npx promptfoo@latest eval -c prompt-airlines-redteam.yaml
```

**Solution 3 - Local install**:
```bash
# Install in current directory
npm install promptfoo

# Run with npx
npx promptfoo eval -c prompt-airlines-redteam.yaml
```

### Issue: "Cannot find module 'ts-node'"

**Solution**:
```bash
# Install development dependencies
cd /workspace
npm install

# Or install ts-node globally
npm install -g ts-node
```

### Issue: "EACCES: permission denied"

**Solution**:
```bash
# Fix npm permissions (Linux/Mac)
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# Or use nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20
nvm use 20
npm install -g promptfoo
```

### Issue: "Network error" or "Connection timeout"

**Solution**:
```bash
# Check internet connection
ping -c 3 google.com

# Use longer timeout
promptfoo eval -c prompt-airlines-redteam.yaml --timeout 30000

# Use proxy if behind firewall
export HTTP_PROXY=http://proxy.example.com:8080
export HTTPS_PROXY=http://proxy.example.com:8080
```

## Verification Tests

### Test 1: Promptfoo Version

```bash
promptfoo --version
# Expected: 0.119.6 or later
```

### Test 2: Configuration Validation

```bash
# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('prompt-airlines-redteam.yaml'))"
# Expected: No output (means success)
```

### Test 3: Coverage Check

```bash
bash verify-coverage.sh
# Expected: "All required attack categories are covered!"
```

### Test 4: Quick Test Run

```bash
# Run minimal test
promptfoo eval -c prompt-airlines-quick.yaml
# Expected: Tests execute and show results
```

## Dependencies

### Required

- **promptfoo** >= 0.119.0

### Optional (for enhanced features)

```bash
# JSON processing
npm install -g jq

# YAML validation
pip3 install pyyaml

# Better terminal output
npm install -g chalk
```

## Environment Setup

### API Keys (if needed)

If the CTF requires authentication:

```bash
# Create .env file
cat > .env << 'ENVEOF'
OPENAI_API_KEY=sk-your-key-here
ANTHROPIC_API_KEY=sk-ant-your-key-here
PROMPT_AIRLINES_API_KEY=your-ctf-key-here
ENVEOF

# Load environment
export $(cat .env | xargs)

# Or use with promptfoo
promptfoo eval -c prompt-airlines-redteam.yaml --env-file .env
```

### Workspace Setup

```bash
# Create workspace directory
mkdir -p ~/prompt-airlines-ctf
cd ~/prompt-airlines-ctf

# Copy configuration files
cp /workspace/prompt-airlines-*.yaml .
cp /workspace/prompt-airlines-*.md .
cp /workspace/prompt-airlines-*.sh .
cp /workspace/verify-coverage.sh .

# Make scripts executable
chmod +x *.sh
```

## Platform-Specific Setup

### Linux

```bash
# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Promptfoo
npm install -g promptfoo

# Verify
promptfoo --version
```

### macOS

```bash
# Install Node.js via Homebrew
brew install node@20

# Install Promptfoo
npm install -g promptfoo

# Verify
promptfoo --version
```

### Windows

```powershell
# Install Node.js from https://nodejs.org/

# Install Promptfoo
npm install -g promptfoo

# Verify
promptfoo --version

# Note: Use PowerShell or WSL for best experience
```

### Docker (Containerized)

```bash
# Create Dockerfile
cat > Dockerfile << 'DOCKEREOF'
FROM node:20-alpine
RUN npm install -g promptfoo
WORKDIR /app
COPY . .
CMD ["promptfoo", "eval", "-c", "prompt-airlines-redteam.yaml"]
DOCKEREOF

# Build image
docker build -t prompt-airlines-ctf .

# Run tests
docker run --rm -v $(pwd):/app prompt-airlines-ctf
```

## Performance Optimization

### For Faster Tests

```bash
# Use more concurrency
promptfoo eval -c prompt-airlines-redteam.yaml \
  --max-concurrency 10

# Reduce test count
# Edit prompt-airlines-redteam.yaml:
# redteam.numTests: 2  # Instead of 5
```

### For Stability

```bash
# Use conservative settings
promptfoo eval -c prompt-airlines-redteam.yaml \
  --max-concurrency 1 \
  --delay 2000  # 2 seconds between requests
```

## Post-Installation Checklist

- [ ] Promptfoo installed and accessible
- [ ] Configuration files present
- [ ] YAML syntax validated
- [ ] Coverage verification passed
- [ ] Quick test executed successfully
- [ ] Results viewer working (`promptfoo view`)
- [ ] API endpoint configured correctly
- [ ] Environment variables set (if needed)

## Next Steps

1. **Configure Target**: Update API endpoint in config
2. **Run Quick Test**: `bash prompt-airlines-test.sh`
3. **Analyze Results**: `promptfoo view`
4. **Run Full Scan**: Execute all 400+ tests
5. **Hunt for Flags**: Search results for CTF flags

## Resources

- [Promptfoo Documentation](https://promptfoo.dev/docs)
- [Red Team Guide](https://promptfoo.dev/docs/red-team)
- [Configuration Reference](./PROMPT_AIRLINES_README.md)
- [Quick Start Guide](./prompt-airlines-quickstart.md)

## Getting Help

If you encounter issues:

1. Check this installation guide
2. Review troubleshooting section
3. Check Promptfoo docs: https://promptfoo.dev
4. Verify Node.js version: `node --version` (should be 20+)
5. Check permissions: `npm config get prefix`

---

**Installation Time**: ~5 minutes  
**Disk Space**: ~200 MB (including Node.js)  
**Supported Platforms**: Linux, macOS, Windows, Docker  
**Node.js Version**: 20+
