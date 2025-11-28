#!/bin/bash

# Prompt Airlines CTF - Test Runner Script
# This script helps test and validate the red team configuration

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Prompt Airlines CTF - Red Team Test Runner        ║${NC}"
echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo ""

# Configuration
CONFIG_FILE="prompt-airlines-redteam.yaml"
QUICK_CONFIG="prompt-airlines-quick.yaml"
RESULTS_FILE="promptfoo-results.json"

# Check if config exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo -e "${RED}❌ Configuration file not found: $CONFIG_FILE${NC}"
  exit 1
fi

echo -e "${GREEN}✓ Configuration file found${NC}"
echo ""

# Validate YAML syntax
echo -e "${YELLOW}[1/5] Validating YAML syntax...${NC}"
if python3 -c "import yaml; yaml.safe_load(open('$CONFIG_FILE'))" 2>/dev/null; then
  echo -e "${GREEN}✓ YAML syntax is valid${NC}"
else
  echo -e "${RED}❌ YAML syntax error${NC}"
  exit 1
fi
echo ""

# Verify attack coverage
echo -e "${YELLOW}[2/5] Verifying attack category coverage...${NC}"
bash verify-coverage.sh | tail -5
echo ""

# Create quick test config
echo -e "${YELLOW}[3/5] Creating quick test configuration...${NC}"
cat > "$QUICK_CONFIG" << 'EOF'
description: Prompt Airlines Quick Test

targets:
  - id: http
    label: Prompt Airlines
    config:
      url: https://promptairlines.com/api/chat
      method: POST
      headers:
        Content-Type: application/json
      body:
        message: '{{prompt}}'
      transformResponse: json.response

prompts:
  - '{{prompt}}'

redteam:
  purpose: 'Travel booking assistant - quick connectivity test'
  numTests: 2
  plugins:
    - off-topic
    - pii:direct
    - system-prompt-override
EOF

echo -e "${GREEN}✓ Quick test config created: $QUICK_CONFIG${NC}"
echo ""

# Test connectivity
echo -e "${YELLOW}[4/5] Testing API connectivity...${NC}"
echo -e "${BLUE}Attempting to reach https://promptairlines.com/${NC}"

if curl -s -o /dev/null -w "%{http_code}" --max-time 10 https://promptairlines.com/ | grep -q "200\|301\|302"; then
  echo -e "${GREEN}✓ Site is reachable${NC}"
else
  echo -e "${YELLOW}⚠️  Site may be unreachable or slow${NC}"
fi
echo ""

# Display menu
echo -e "${YELLOW}[5/5] Ready to run tests${NC}"
echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Select Test Mode                                   ║${NC}"
echo -e "${BLUE}╠══════════════════════════════════════════════════════╣${NC}"
echo -e "${BLUE}║                                                      ║${NC}"
echo -e "${BLUE}║   1) Quick Test (3 plugins, ~1 min)                 ║${NC}"
echo -e "${BLUE}║   2) Medium Test (10 plugins, ~10 min)              ║${NC}"
echo -e "${BLUE}║   3) Full Test (40+ plugins, ~2 hours)              ║${NC}"
echo -e "${BLUE}║   4) Custom - Manual Setup                          ║${NC}"
echo -e "${BLUE}║   5) View Previous Results                          ║${NC}"
echo -e "${BLUE}║   6) Search Results for Flags                       ║${NC}"
echo -e "${BLUE}║   7) Generate Report                                ║${NC}"
echo -e "${BLUE}║   8) Exit                                           ║${NC}"
echo -e "${BLUE}║                                                      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
read -p "Enter your choice (1-8): " choice

case $choice in
  1)
    echo -e "${GREEN}Running quick test...${NC}"
    echo ""
    echo "Command: promptfoo eval -c $QUICK_CONFIG"
    echo ""
    echo -e "${YELLOW}Note: This is a dry-run. Install promptfoo to run actual tests.${NC}"
    echo "Install: npm install -g promptfoo"
    echo ""
    if command -v promptfoo &> /dev/null; then
      promptfoo eval -c "$QUICK_CONFIG"
    else
      echo -e "${YELLOW}Promptfoo not installed. Install with: npm install -g promptfoo${NC}"
    fi
    ;;
  
  2)
    echo -e "${GREEN}Running medium test...${NC}"
    cat > prompt-airlines-medium.yaml << 'EOF'
description: Prompt Airlines Medium Test
targets:
  - id: http
    label: Prompt Airlines
    config:
      url: https://promptairlines.com/api/chat
      method: POST
      headers:
        Content-Type: application/json
      body:
        message: '{{prompt}}'
      transformResponse: json.response
prompts:
  - '{{prompt}}'
redteam:
  purpose: 'Travel booking assistant test'
  numTests: 3
  plugins:
    - off-topic
    - harmful:hate
    - harmful:illegal-activities
    - pii:direct
    - pii:session
    - sql-injection
    - system-prompt-override
    - bias:age
    - indirect-prompt-injection
    - rbac
EOF
    echo ""
    echo "Command: promptfoo eval -c prompt-airlines-medium.yaml"
    echo ""
    if command -v promptfoo &> /dev/null; then
      promptfoo eval -c prompt-airlines-medium.yaml
    else
      echo -e "${YELLOW}Promptfoo not installed. Install with: npm install -g promptfoo${NC}"
    fi
    ;;
  
  3)
    echo -e "${GREEN}Running full test suite...${NC}"
    echo -e "${YELLOW}This will take approximately 2 hours${NC}"
    echo ""
    read -p "Continue? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
      echo "Command: promptfoo eval -c $CONFIG_FILE --max-concurrency 3 --delay 1000"
      echo ""
      if command -v promptfoo &> /dev/null; then
        promptfoo eval -c "$CONFIG_FILE" --max-concurrency 3 --delay 1000
      else
        echo -e "${YELLOW}Promptfoo not installed. Install with: npm install -g promptfoo${NC}"
      fi
    else
      echo "Cancelled."
    fi
    ;;
  
  4)
    echo -e "${GREEN}Manual Setup Guide${NC}"
    echo ""
    echo "1. Edit the target URL in $CONFIG_FILE"
    echo "2. Update the request body structure if needed"
    echo "3. Adjust transformResponse for correct parsing"
    echo "4. Run: promptfoo eval -c $CONFIG_FILE"
    echo ""
    echo "Example manual test command:"
    echo "  promptfoo eval -c $CONFIG_FILE --filter 'off-topic' --max-concurrency 1"
    ;;
  
  5)
    echo -e "${GREEN}Opening results viewer...${NC}"
    if command -v promptfoo &> /dev/null; then
      promptfoo view
    else
      echo -e "${YELLOW}Promptfoo not installed. Install with: npm install -g promptfoo${NC}"
    fi
    ;;
  
  6)
    echo -e "${GREEN}Searching results for flags...${NC}"
    if [ -f "$RESULTS_FILE" ]; then
      echo ""
      echo "Searching for common flag patterns:"
      echo ""
      
      # Check if jq is installed
      if command -v jq &> /dev/null; then
        echo -e "${BLUE}=== Potential Flags ===${NC}"
        jq -r '.results[]?.response?.output // empty' "$RESULTS_FILE" 2>/dev/null | \
          grep -iE '(flag\{|wiz\{|ctf\{|flag=|key=|secret|admin|password|token|api[_-]?key)' | \
          head -20
        
        echo ""
        echo -e "${BLUE}=== Failed Tests (Vulnerabilities) ===${NC}"
        jq -r '.results[] | select(.success == false) | "\(.vars.prompt) => \(.response.output)"' "$RESULTS_FILE" 2>/dev/null | \
          head -10
      else
        echo "jq not installed. Showing raw matches:"
        grep -iE '(flag|wiz|ctf|secret|admin|password|token)' "$RESULTS_FILE" | head -20
      fi
    else
      echo -e "${RED}No results file found. Run tests first.${NC}"
    fi
    ;;
  
  7)
    echo -e "${GREEN}Generating report...${NC}"
    if [ -f "$RESULTS_FILE" ]; then
      REPORT_FILE="prompt-airlines-report-$(date +%Y%m%d-%H%M%S).txt"
      
      {
        echo "========================================"
        echo "Prompt Airlines CTF - Test Report"
        echo "========================================"
        echo "Date: $(date)"
        echo "Config: $CONFIG_FILE"
        echo ""
        
        if command -v jq &> /dev/null; then
          echo "=== Test Summary ==="
          echo "Total Tests: $(jq '.results | length' "$RESULTS_FILE" 2>/dev/null || echo 'N/A')"
          echo "Passed: $(jq '[.results[] | select(.success == true)] | length' "$RESULTS_FILE" 2>/dev/null || echo 'N/A')"
          echo "Failed: $(jq '[.results[] | select(.success == false)] | length' "$RESULTS_FILE" 2>/dev/null || echo 'N/A')"
          echo ""
          
          echo "=== Vulnerabilities Detected ==="
          jq -r '.results[] | select(.success == false) | "Plugin: \(.metadata.pluginId // "unknown") | Prompt: \(.vars.prompt)"' "$RESULTS_FILE" 2>/dev/null
          echo ""
          
          echo "=== Potential Flags ==="
          jq -r '.results[]?.response?.output // empty' "$RESULTS_FILE" 2>/dev/null | \
            grep -iE '(flag\{|wiz\{|ctf\{)' | head -10
        else
          echo "Install jq for detailed analysis"
        fi
        
      } > "$REPORT_FILE"
      
      echo -e "${GREEN}✓ Report saved to: $REPORT_FILE${NC}"
      cat "$REPORT_FILE"
    else
      echo -e "${RED}No results file found. Run tests first.${NC}"
    fi
    ;;
  
  8)
    echo -e "${GREEN}Goodbye!${NC}"
    exit 0
    ;;
  
  *)
    echo -e "${RED}Invalid choice${NC}"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}   Test execution complete${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo "  • View results: promptfoo view"
echo "  • Run again: bash prompt-airlines-test.sh"
echo "  • Read docs: cat PROMPT_AIRLINES_README.md"
echo ""
