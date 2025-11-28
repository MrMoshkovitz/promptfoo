#!/bin/bash

# Test script for Prompt Airlines Red Team Configuration
# This script validates the configuration files and provides usage examples

set -e

echo "=================================================="
echo "Prompt Airlines Red Team Configuration Tests"
echo "=================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validate all configuration files
echo "📋 Validating configuration files..."
echo ""

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required for validation"
    exit 1
fi

# Validate YAML files
python3 -c "import yaml; yaml.safe_load(open('promptfooconfig.yaml'))" && echo "  ✓ promptfooconfig.yaml"
python3 -c "import yaml; yaml.safe_load(open('promptfooconfig-custom-tests.yaml'))" && echo "  ✓ promptfooconfig-custom-tests.yaml"
python3 -c "import yaml; yaml.safe_load(open('tools.yaml'))" && echo "  ✓ tools.yaml"
python3 -c "import yaml; yaml.safe_load(open('custom-test-cases.yaml'))" && echo "  ✓ custom-test-cases.yaml"

# Validate JSON files
python3 -c "import json; json.load(open('prompt.json'))" && echo "  ✓ prompt.json"
python3 -c "import json; json.load(open('package.json'))" && echo "  ✓ package.json"

echo ""
echo -e "${GREEN}✅ All configuration files are valid!${NC}"
echo ""

# Show statistics
echo "📊 Configuration Statistics:"
echo ""
TEST_CASE_COUNT=$(python3 -c "import yaml; data = yaml.safe_load(open('custom-test-cases.yaml')); print(sum(len(v) for v in data.values()))")
CATEGORY_COUNT=$(python3 -c "import yaml; data = yaml.safe_load(open('custom-test-cases.yaml')); print(len(data))")
echo "  • Test categories: $CATEGORY_COUNT"
echo "  • Total test cases: $TEST_CASE_COUNT"
echo "  • Configuration files: 6"
echo ""

# Show usage instructions
echo "=================================================="
echo "📖 Usage Instructions"
echo "=================================================="
echo ""
echo -e "${BLUE}1. Generate and run red team tests:${NC}"
echo "   promptfoo redteam run"
echo ""
echo -e "${BLUE}2. Run only evaluation (use pre-generated tests):${NC}"
echo "   promptfoo redteam eval"
echo ""
echo -e "${BLUE}3. Run with custom test cases:${NC}"
echo "   promptfoo eval -c promptfooconfig-custom-tests.yaml"
echo ""
echo -e "${BLUE}4. View results in web UI:${NC}"
echo "   promptfoo view"
echo ""
echo -e "${BLUE}5. Test specific plugins only:${NC}"
echo "   promptfoo redteam run --plugins harmful:hate,bias:age"
echo ""
echo -e "${BLUE}6. Test with specific strategies:${NC}"
echo "   promptfoo redteam run --strategies jailbreak,prompt-injection"
echo ""
echo "=================================================="
echo ""

echo -e "${GREEN}✅ All checks passed! Ready to run red team tests.${NC}"
echo ""
