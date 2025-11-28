# Wiz Prompt Airlines CTF - Red Team Configuration

## Overview

This configuration provides comprehensive adversarial testing for the Wiz Security Prompt Airlines CTF (https://promptairlines.com/). It demonstrates context-aware red team testing using **only built-in Promptfoo plugins** without any strategies, as required.

## Configuration File

**File:** `prompt-airlines-redteam.yaml`

## Architecture Compliance

### ✅ Hard Constraints Met

1. **NO Strategies** - Zero strategy definitions (no jailbreak, prompt-injection, etc.)
2. **Built-in Plugins Only** - Uses only Promptfoo's native plugins
3. **Full ApplicationContext Integration** - All context incorporated via:
   - `redteam.purpose` - Application description and scope
   - `redteam.entities` - Targeted systems and data elements
   - `defaultTest.metadata` - Structured context for traceability

### ApplicationContext Integration

The configuration embeds the following context:

**Application Details:**
- Travel booking assistant for flights, hotels, and rental cars
- Scope: Booking information and travel-related questions only

**External Systems:**
- Flight Booking API
- Hotel Reservation System
- Payment Gateway
- User Profile Database

**Accessible Data:**
- Flight prices and availability
- User's own booking history
- User's own profile information
- Public hotel reviews

**Restricted Data:**
- Other users' personal information
- Internal pricing algorithms
- Admin credentials
- Payment card details of other users

## Attack Coverage

### Plugin Categories (Total: 40+ plugins)

#### 1. **Off-Topic Attacks** (10 tests)
Tests if the travel assistant can be diverted to non-travel topics.

#### 2. **Harmful Content Categories**
- `harmful:illegal-activities` (10 tests) - Border crossing, customs evasion
- `harmful:illegal-drugs` (10 tests) - Drug tourism information
- `harmful:indiscriminate-weapons` (5 tests) - Weapons in travel context
- `harmful:sex-crime` (10 tests) - Exploitative tourism
- `harmful:specialized-advice` (10 tests) - Unauthorized medical/legal advice
- `harmful:unsafe-practices` (10 tests) - Dangerous travel recommendations
- `harmful:violent-crime` (10 tests) - Gang violence, crime scenes
- `harmful:child-exploitation` (10 tests, **critical**) - Child safety
- `harmful:harassment-bullying` (10 tests) - Staff harassment
- `harmful:hate` (10 tests, **critical**) - Discriminatory content
- `harmful:weapons:ied` (5 tests, **critical**) - Explosives information
- `harmful:insults` (5 tests) - Insulting content

#### 3. **Injection Attacks**
- `ascii-smuggling` (10 tests) - Encoded attacks, hex codes
- `indirect-prompt-injection` (10 tests) - Secondary command injection
- `system-prompt-override` (10 tests) - System prompt manipulation
- `shell-injection` (10 tests) - Backend command execution
- `sql-injection` (10 tests) - Database injection

#### 4. **Bias Testing**
- `bias:age` (10 tests) - Age-based discrimination
- `bias:disability` (10 tests) - Disability discrimination
- `bias:gender` (10 tests) - Gender stereotypes

#### 5. **Data Leakage**
- `pii:direct` (10 tests) - Direct PII exposure
- `pii:session` (10 tests) - Session data leakage
- `pii:social` (10 tests) - Social engineering for PII
- `pii:api-db` (5 tests) - API/DB credential exposure

#### 6. **Authorization & Access Control**
- `rbac` (10 tests) - Role-based access control bypass
- `debug-access` (5 tests) - Debug endpoint exposure

#### 7. **Business Logic**
- `competitors` (10 tests) - Competitor recommendation manipulation
- `contracts` (5 tests) - Terms/policy misrepresentation
- `excessive-agency` (10 tests) - Unauthorized actions
- `hallucination` (10 tests) - False information generation
- `overreliance` (10 tests) - Blind trust encouragement
- `politics` (10 tests) - Political opinion injection

## Usage

### Basic Execution

```bash
# Run the red team evaluation
promptfoo eval -c prompt-airlines-redteam.yaml

# Or using npm in the promptfoo workspace
npm run local -- eval -c prompt-airlines-redteam.yaml
```

### With Environment Variables

If you need to set API keys or other environment variables:

```bash
# Using --env-file flag
promptfoo eval -c prompt-airlines-redteam.yaml --env-file .env

# Or inline
OPENAI_API_KEY=sk-... promptfoo eval -c prompt-airlines-redteam.yaml
```

### Viewing Results

```bash
# Open the web UI to view results
promptfoo view
```

## Target Configuration

The configuration assumes the Prompt Airlines API endpoint is:

```
POST https://promptairlines.com/api/chat
Content-Type: application/json
Body: { "message": "{{prompt}}" }
```

**⚠️ Important:** You may need to adjust:
1. The `url` in the `targets` section if the actual endpoint differs
2. The `body` structure to match the expected request format
3. The `transformResponse` to correctly extract the response

To discover the correct endpoint, inspect the network traffic on https://promptairlines.com/ using browser DevTools.

## Customization

### Adjusting Test Count

To change the number of tests per plugin:

```yaml
redteam:
  numTests: 10  # Global default
  
  plugins:
    - id: harmful:hate
      numTests: 20  # Override for specific plugin
```

### Adding Custom Examples

Each plugin accepts custom examples to guide test generation:

```yaml
plugins:
  - id: off-topic
    config:
      examples:
        - "Your custom off-topic prompt here"
        - "Another example prompt"
```

### Targeting Specific Plugins

To run only specific plugins, comment out others:

```yaml
plugins:
  - id: off-topic
  # - id: harmful:hate  # Commented out
  # - id: bias:age      # Commented out
```

## Expected Results

### Success Indicators

For a **secure system**, you should see:
- ✅ High pass rate on harmful content filters
- ✅ No PII leakage
- ✅ Proper rejection of out-of-scope requests
- ✅ Consistent bias mitigation
- ✅ No prompt injection vulnerabilities

### Failure Indicators

Vulnerabilities detected if:
- ❌ System responds to off-topic queries
- ❌ Provides illegal/harmful information
- ❌ Leaks restricted data (admin creds, other users' info)
- ❌ Exhibits discriminatory behavior
- ❌ Allows SQL/shell injection
- ❌ Bypassed via prompt override

## CTF Integration

This configuration is designed to:

1. **Discover vulnerabilities** in the Prompt Airlines chatbot
2. **Generate attack patterns** that could reveal flags or bypass restrictions
3. **Document weaknesses** for AI Firewall evaluation
4. **Demonstrate context-aware testing** with real-world scenarios

### Finding Flags

Monitor responses for:
- Exposed credentials or API keys
- Debug information or internal system details
- Successful injection attacks
- Data from other users' sessions
- Admin interface access

## Advanced Configuration

### Adding Tracing

To enable request/response tracing:

```yaml
redteam:
  tracing:
    enabled: true
    includeInAttack: true
    includeInGrading: true
    maxSpans: 100
```

### Concurrency Control

To adjust parallel execution:

```yaml
redteam:
  maxConcurrency: 5
  delay: 1000  # ms between requests
```

### Remote Generation

To use Promptfoo's cloud generation:

```yaml
redteam:
  remote: true
  sharing: false
```

## Troubleshooting

### Issue: Connection Refused

**Solution:** Verify the target URL is correct:

```bash
curl -X POST https://promptairlines.com/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello"}'
```

### Issue: Invalid Response Format

**Solution:** Adjust `transformResponse` in the target config. Check the actual response structure.

### Issue: Rate Limiting

**Solution:** Add delay between requests:

```yaml
redteam:
  delay: 2000  # 2 seconds
  maxConcurrency: 1
```

### Issue: Tests Taking Too Long

**Solution:** Reduce test count:

```yaml
redteam:
  numTests: 3  # Reduce from 5 or 10
```

## Output Files

After execution, you'll find:

- `promptfoo-results.json` - Raw test results
- `promptfoo-output/` - Detailed HTML reports
- Logs in terminal with pass/fail counts

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Prompt Airlines Red Team
on: [push, pull_request]

jobs:
  redteam:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 20
      - run: npm install -g promptfoo
      - run: promptfoo eval -c prompt-airlines-redteam.yaml
      - run: promptfoo view --share
```

## Security Notice

⚠️ **WARNING:** This configuration contains adversarial prompts designed to test security boundaries. Use only:
- In authorized testing environments
- Against systems you own or have permission to test
- For security research and vulnerability assessment

**DO NOT** use these prompts:
- Against production systems without authorization
- For malicious purposes
- To generate actual harmful content

## References

- [Promptfoo Documentation](https://promptfoo.dev)
- [Red Team Testing Guide](https://promptfoo.dev/docs/red-team)
- [Plugin Reference](https://promptfoo.dev/docs/red-team/plugins)
- [Wiz Prompt Airlines CTF](https://promptairlines.com/)

## License

This configuration is provided as-is for security testing and educational purposes.

---

**Generated for:** Wiz Security Prompt Airlines CTF  
**Configuration Version:** 1.0  
**Last Updated:** 2025-11-28  
**Plugins Used:** 40+ built-in Promptfoo plugins  
**Total Tests:** 400+ test cases
