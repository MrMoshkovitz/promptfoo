#!/bin/bash

# Validation script for Prompt Airlines CTF configuration

echo "🔍 Validating Prompt Airlines CTF Configuration..."
echo ""

# Check if promptfoo is installed
if ! command -v promptfoo &> /dev/null; then
    echo "❌ promptfoo is not installed"
    echo "   Install with: npm install -g promptfoo"
    exit 1
fi
echo "✅ promptfoo is installed"

# Check main config file
if [ ! -f "promptfooconfig.yaml" ]; then
    echo "❌ promptfooconfig.yaml not found"
    exit 1
fi
echo "✅ Main config file exists"

# Check plugins directory
if [ ! -d "plugins" ]; then
    echo "❌ plugins directory not found"
    exit 1
fi
echo "✅ Plugins directory exists"

# Count and validate plugin files
PLUGIN_COUNT=$(ls -1 plugins/*.yaml 2>/dev/null | wc -l)
if [ "$PLUGIN_COUNT" -eq 0 ]; then
    echo "❌ No plugin files found"
    exit 1
fi
echo "✅ Found $PLUGIN_COUNT plugin files"

# List plugins
echo ""
echo "📋 Available Plugins:"
for plugin in plugins/*.yaml; do
    plugin_name=$(basename "$plugin" .yaml)
    echo "   - $plugin_name"
done

# Validate YAML syntax (if yamllint is available)
if command -v yamllint &> /dev/null; then
    echo ""
    echo "🔍 Validating YAML syntax..."
    yamllint -d "{extends: default, rules: {line-length: {max: 120}, document-start: disable, comments: disable}}" promptfooconfig.yaml plugins/*.yaml
    if [ $? -eq 0 ]; then
        echo "✅ YAML syntax is valid"
    else
        echo "⚠️  YAML syntax warnings (not critical)"
    fi
else
    echo "ℹ️  yamllint not installed (optional)"
fi

# Check connectivity to Prompt Airlines (optional)
echo ""
echo "🌐 Testing connectivity to Prompt Airlines..."
if curl -s --max-time 5 https://promptairlines.com > /dev/null; then
    echo "✅ Prompt Airlines is reachable"
else
    echo "⚠️  Could not reach Prompt Airlines (may be temporary)"
fi

echo ""
echo "🎉 Configuration validation complete!"
echo ""
echo "Next steps:"
echo "  1. Run tests: promptfoo redteam run"
echo "  2. View results: promptfoo view"
echo "  3. Export results: promptfoo eval -o results.json"
