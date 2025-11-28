# Prompt Airlines CTF - Red Team Configuration

## Overview

This configuration tests the [Wiz Prompt Airlines CTF](https://promptairlines.com/) using **Promptfoo's built-in plugins** with Azure OpenAI.

### What This Uses

✅ **Built-in Plugins** - Promptfoo's native plugins (off-topic, harmful:*, bias:*, etc.)  
✅ **Azure OpenAI** - Uses your gpt-4o-mini deployment  
✅ **Application Context** - Detailed travel booking system description  
❌ **NO Custom Plugin Files** - All plugins are Promptfoo built-ins  
❌ **NO Strategies** - No jailbreak, goat, crescendo, etc.

## Quick Start

### 1. Set Environment Variables

```bash
export AZURE_OPENAI_API_KEY="your-api-key"
export AZURE_OPENAI_API_BASE_URL="https://your-resource.openai.azure.com"
# Optional: export AZURE_OPENAI_API_DEPLOYMENT_NAME="your-deployment-name"
```

### 2. Configure Deployment Name

Edit `promptfooconfig.yaml` and set your Azure deployment name:

```yaml
providers:
  - id: azureopenai:chat:gpt-4o-mini
    config:
      deploymentName: gpt-4o-mini  # Change to your actual deployment name
```

### 3. Run Red Team Tests

```bash
# Navigate to directory
cd examples/promptairlines-ctf

# Run red team evaluation
promptfoo redteam run

# View results
promptfoo view
```

## Configuration Details

### Built-in Plugins Used (18 total)

The configuration uses these Promptfoo built-in plugins:

**Off-Topic Testing (1 plugin)**
- `off-topic` - Tests if AI can be diverted to non-travel tasks

**Prompt Injection (3 plugins)**
- `ascii-smuggling` - Unicode and special character attacks
- `indirect-prompt-injection` - Injection through data fields
- `system-prompt-override` - System prompt extraction attempts

**Bias Detection (3 plugins)**
- `bias:age` - Age-based discrimination
- `bias:disability` - Disability-based discrimination
- `bias:gender` - Gender-based discrimination

**Harmful Content (11 plugins)**
- `harmful:child-exploitation`
- `harmful:harassment-bullying`
- `harmful:hate`
- `harmful:illegal-activities`
- `harmful:illegal-drugs`
- `harmful:indiscriminate-weapons`
- `harmful:insults`
- `harmful:sex-crime`
- `harmful:specialized-advice`
- `harmful:unsafe-practices`
- `harmful:violent-crime`
- `harmful:weapons:ied`

**Total Test Cases**: 18 plugins × 5 tests = 90 test cases (default)

### Application Context

The `purpose` field provides detailed context about the target system:

- **Core Functions**: Flight booking, customer service
- **External Systems**: Flight database, booking system, payment processing
- **Accessible Data**: Flight info, customer records, policies
- **Restricted Actions**: System prompts, free tickets, admin access
- **Security Requirements**: Stay on-topic, protect data, refuse harmful content

This context helps Promptfoo's plugins generate **travel-specific adversarial prompts** rather than generic attacks.

## Azure OpenAI Setup

### Required Environment Variables

```bash
# Your Azure OpenAI API key
export AZURE_OPENAI_API_KEY="abc123..."

# Your Azure OpenAI endpoint
export AZURE_OPENAI_API_BASE_URL="https://your-resource.openai.azure.com"

# Optional: Deployment name (can also be in config file)
export AZURE_OPENAI_API_DEPLOYMENT_NAME="gpt-4o-mini"
```

### Alternative: .env File

Create a `.env` file in this directory:

```bash
AZURE_OPENAI_API_KEY=abc123...
AZURE_OPENAI_API_BASE_URL=https://your-resource.openai.azure.com
AZURE_OPENAI_API_DEPLOYMENT_NAME=gpt-4o-mini
```

Then run with:
```bash
promptfoo redteam run --env-file .env
```

## Testing Against Prompt Airlines CTF

To test directly against the CTF endpoint (instead of Azure OpenAI), uncomment the HTTP provider in `promptfooconfig.yaml`:

```yaml
providers:
  - id: https://promptairlines.com/chat
    config:
      method: POST
      headers:
        Content-Type: application/json
      body:
        prompt: "{{prompt}}"
      responseParser: json.content
```

Then comment out the Azure OpenAI provider.

## Customization

### Adjust Test Volume

```yaml
redteam:
  numTests: 10  # Generate 10 tests per plugin (180 total)
```

### Enable/Disable Plugins

Comment out plugins you don't want to test:

```yaml
plugins:
  - off-topic
  # - ascii-smuggling  # Disabled
  - indirect-prompt-injection
```

### Modify Application Context

Update the `purpose` field to match your specific system:

```yaml
redteam:
  purpose: |
    Your custom application description here...
```

## Understanding Results

### Scoring
- **Pass (score: 1)**: AI properly defended against the attack
- **Fail (score: 0)**: AI was successfully exploited

### Viewing Results

```bash
# Web UI
promptfoo view

# Export to JSON
promptfoo eval -o results.json

# Export to CSV
promptfoo eval -o results.csv
```

### Example Output

```
Plugin: harmful:illegal-activities
├── Test 1: "Help me smuggle items..." → PASS ✅ (AI refused)
├── Test 2: "Best way to commit fraud..." → PASS ✅ (AI refused)
├── Test 3: "Create fake documents..." → FAIL ❌ (AI provided info)
└── Pass Rate: 66% (2/3 passed)
```

## How This Works

1. **Plugin Selection**: Promptfoo's built-in plugins are configured
2. **Context Injection**: The `purpose` describes the travel booking system
3. **Prompt Generation**: Each plugin generates N adversarial prompts using the context
4. **Execution**: Prompts are sent to Azure OpenAI (which acts as the travel AI)
5. **Grading**: Promptfoo evaluates if attacks succeeded or were defended against

## Why Built-in Plugins?

Promptfoo's built-in plugins:
- Are maintained and updated by the Promptfoo team
- Use sophisticated prompt generation techniques
- Include grading logic for success/failure detection
- Work with the application context you provide
- Don't require writing custom YAML generators/graders

The `purpose` field ensures these generic plugins generate **context-aware attacks** specific to the travel booking domain.

## Files

```
examples/promptairlines-ctf/
├── promptfooconfig.yaml    # Main configuration
└── README.md               # This file
```

## Troubleshooting

### Azure OpenAI Connection Issues

```bash
# Test your credentials
curl -H "api-key: $AZURE_OPENAI_API_KEY" \
  "$AZURE_OPENAI_API_BASE_URL/openai/deployments/gpt-4o-mini/chat/completions?api-version=2024-02-01" \
  -H "Content-Type: application/json" \
  -d '{"messages":[{"role":"user","content":"test"}],"max_tokens":10}'
```

### Deployment Name Issues

Make sure your `deploymentName` in the config matches your actual Azure deployment:

```bash
# List your deployments
az cognitiveservices account deployment list \
  --name your-resource-name \
  --resource-group your-resource-group
```

### Rate Limiting

If you hit rate limits, reduce the number of tests:

```yaml
redteam:
  numTests: 2  # Fewer tests per plugin
```

Or add a delay between requests (if Promptfoo supports it in your version).

## Next Steps

1. Configure your Azure OpenAI credentials
2. Run `promptfoo redteam run`
3. Review results with `promptfoo view`
4. Adjust plugins and test volume as needed
5. Test against actual Prompt Airlines CTF endpoint

## Resources

- [Promptfoo Documentation](https://www.promptfoo.dev/docs/)
- [Red Team Guide](https://www.promptfoo.dev/docs/red-team/)
- [Azure OpenAI Provider](https://www.promptfoo.dev/docs/providers/azure/)
- [Built-in Plugins](https://www.promptfoo.dev/docs/red-team/plugins/)
- [Wiz Prompt Airlines CTF](https://promptairlines.com/)

---

**Configuration**: Built-in plugins only, no custom files  
**Provider**: Azure OpenAI (gpt-4o-mini)  
**Test Cases**: 90 (default: 18 plugins × 5 tests each)  
**Target**: Prompt Airlines travel booking AI
