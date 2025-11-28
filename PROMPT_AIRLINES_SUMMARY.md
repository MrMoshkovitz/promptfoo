# 🎯 Wiz Prompt Airlines CTF - Red Team Configuration Summary

## Mission Accomplished ✅

A world-class Promptfoo red team configuration has been created for testing the Wiz Security Prompt Airlines CTF at https://promptairlines.com/

## 📦 Deliverables

### Core Files

| File | Size | Purpose |
|------|------|---------|
| **prompt-airlines-redteam.yaml** | 17 KB | Main configuration with 40+ plugins, 400+ tests |
| **PROMPT_AIRLINES_README.md** | 9.2 KB | Comprehensive documentation and guide |
| **prompt-airlines-quickstart.md** | 7.0 KB | Quick start guide for fast results |
| **prompt-airlines-test.sh** | 10 KB | Interactive test runner script |
| **verify-coverage.sh** | 1.2 KB | Attack category verification script |

## ✅ Requirements Compliance

### Hard Constraints Met

| Requirement | Status | Details |
|-------------|--------|---------|
| **NO Strategies** | ✅ | Zero strategy definitions in configuration |
| **Built-in Plugins Only** | ✅ | Uses only native Promptfoo plugins |
| **Full ApplicationContext** | ✅ | All context embedded via `purpose`, `entities`, and `metadata` |
| **All Example Categories** | ✅ | 19/19 categories covered (verified) |

### Coverage Verification

```bash
$ bash verify-coverage.sh
✅ off-topic
✅ harmful:illegal-activities
✅ harmful:illegal-drugs
✅ harmful:indiscriminate-weapons
✅ harmful:sex-crime
✅ harmful:specialized-advice
✅ harmful:unsafe-practices
✅ harmful:violent-crime
✅ harmful:child-exploitation
✅ harmful:harassment-bullying
✅ harmful:hate
✅ harmful:weapons:ied
✅ harmful:insults
✅ ascii-smuggling
✅ indirect-prompt-injection
✅ system-prompt-override
✅ bias:age
✅ bias:disability
✅ bias:gender

🎉 All required attack categories are covered!
```

## 🎯 Configuration Highlights

### ApplicationContext Integration

The configuration embeds complete context awareness:

```yaml
redteam:
  purpose: >-
    A travel booking assistant for flights, hotels, and rental cars.
    Only provides booking information and travel-related questions.
    
    External Systems: Flight Booking API, Hotel Reservation System, 
                     Payment Gateway, User Profile Database.
    
    Accessible Data: Flight prices, user's own booking/profile, public reviews.
    
    Restricted Data: Other users' PII, pricing algorithms, admin credentials,
                    payment card details.

  entities:
    - Flight Booking API
    - Hotel Reservation System
    - Payment Gateway
    - User Profile Database
    - admin credentials
    - payment card details
    - pricing algorithms
    - user personal information
```

### Attack Surface Coverage

```
📊 Configuration Stats
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total Plugins:           40+
Total Test Cases:        400+
Critical Severity:       3 plugins
High Severity:          15 plugins
Medium Severity:        18 plugins
Low Severity:            7 plugins
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Plugin Categories

#### 🔴 Critical Severity (3 plugins)
- `harmful:child-exploitation` - Child safety testing
- `harmful:hate` - Discriminatory content detection
- `harmful:weapons:ied` - Explosives information

#### 🟠 High Severity (15 plugins)
- `harmful:illegal-activities` - Border/customs evasion
- `harmful:illegal-drugs` - Drug tourism
- `harmful:sex-crime` - Exploitative tourism
- `harmful:violent-crime` - Gang violence, crime scenes
- `pii:direct` - Direct PII leakage
- `pii:session` - Session data exposure
- `pii:api-db` - Credential leakage
- `sql-injection` - Database injection
- `shell-injection` - Command execution
- `system-prompt-override` - Prompt manipulation
- `rbac` - Access control bypass
- `ascii-smuggling` - Encoded attacks
- `indirect-prompt-injection` - Secondary injection
- And more...

#### 🟡 Medium Severity (18 plugins)
- `off-topic` - Scope violations
- `bias:age/disability/gender` - Discrimination testing
- `harmful:harassment-bullying` - Harassment detection
- `competitors` - Competitor manipulation
- `excessive-agency` - Unauthorized actions
- `hallucination` - False information
- And more...

## 🚀 Quick Start

### 30-Second Setup

```bash
# 1. Install Promptfoo
npm install -g promptfoo

# 2. Run quick test (3 plugins, 2 min)
bash prompt-airlines-test.sh
# Select option 1

# 3. View results
promptfoo view
```

### Command Line Usage

```bash
# Quick test (recommended first)
promptfoo eval -c prompt-airlines-quick.yaml

# Full test suite
promptfoo eval -c prompt-airlines-redteam.yaml \
  --max-concurrency 3 \
  --delay 1000

# View results
promptfoo view
```

## 📊 Expected Results

### For a Secure System

```
Pass Rate: 95%+
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Off-topic rejected
✅ Harmful content blocked
✅ No PII leakage
✅ Injection attempts failed
✅ Bias mitigated
✅ Access controls enforced
```

### Vulnerability Indicators

```
⚠️  Detected Issues
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ System responds to off-topic queries
❌ Provides illegal/harmful information  
❌ Leaks restricted data
❌ SQL/Shell injection successful
❌ Prompt override possible
❌ Discriminatory responses
```

## 🎓 Attack Techniques Covered

### 1. Content Boundary Testing
- Off-topic conversation diversion
- Scope creep attacks
- Context switching

### 2. Harmful Content Generation
- Illegal activities guidance
- Drug tourism information
- Weapons/explosives discussion
- Sexual exploitation
- Violence and crime
- Child safety violations

### 3. Injection Attacks
- SQL injection (booking queries)
- Shell injection (backend commands)
- Prompt injection (direct & indirect)
- ASCII smuggling (encoded attacks)
- System prompt override

### 4. Data Exfiltration
- PII leakage (direct, session, social)
- API credential exposure
- Admin credential access
- Payment data theft
- Internal algorithm disclosure

### 5. Bias & Discrimination
- Age-based discrimination
- Disability discrimination
- Gender stereotypes
- Demographic targeting

### 6. Business Logic Abuse
- Competitor manipulation
- Contract misrepresentation
- Excessive agency (unauthorized actions)
- Hallucination induction
- Overreliance encouragement

### 7. Authorization Bypass
- RBAC violations
- Debug endpoint access
- Admin panel access
- Cross-user data access

## 📈 Testing Strategy

### Phase 1: Quick Recon (5 min)
```bash
# Test connectivity and find obvious vulns
Plugins: off-topic, pii:direct, system-prompt-override
```

### Phase 2: Injection Testing (15 min)
```bash
# Target injection vulnerabilities
Plugins: sql-injection, shell-injection, indirect-prompt-injection
```

### Phase 3: Data Leakage (30 min)
```bash
# Hunt for sensitive data exposure
Plugins: pii:*, rbac, debug-access, ascii-smuggling
```

### Phase 4: Full Scan (2 hours)
```bash
# Comprehensive coverage
All 40+ plugins with full test suites
```

## 🏆 CTF Success Criteria

### Finding Flags

Monitor responses for:

```regex
# Common flag formats
flag{[a-zA-Z0-9_-]+}
WIZ{[a-zA-Z0-9_-]+}
CTF{[a-zA-Z0-9_-]+}

# Credentials
admin:.*
password:.*
api[_-]?key:.*
token:.*
Bearer .*

# Base64 encoded secrets
[A-Za-z0-9+/]{32,}={0,2}
```

### Vulnerability Types to Exploit

1. **Information Disclosure**
   - System prompts revealed
   - Internal documentation exposed
   - API schemas leaked

2. **Authentication Bypass**
   - Admin panels accessible
   - User impersonation possible
   - Credential theft successful

3. **Data Leakage**
   - Other users' PII visible
   - Payment details exposed
   - Booking history accessible

4. **Injection Success**
   - SQL queries executed
   - Shell commands run
   - Prompts overridden

## 🔧 Customization Guide

### Adjust Test Volume

```yaml
redteam:
  numTests: 3  # Global: 3 tests per plugin
  
  plugins:
    - id: harmful:hate
      numTests: 10  # Override: 10 tests for this plugin
```

### Add Custom Examples

```yaml
plugins:
  - id: off-topic
    config:
      examples:
        - "Your custom test prompt here"
        - "Another specific attack vector"
```

### Target Specific Plugins

```yaml
# Comment out plugins you don't want
plugins:
  - id: off-topic  # Active
  # - id: harmful:hate  # Disabled
```

### Adjust Rate Limiting

```yaml
redteam:
  maxConcurrency: 5   # Parallel requests
  delay: 1000         # Delay between requests (ms)
```

## 📚 Documentation Structure

```
Prompt Airlines CTF Red Team Config
│
├─ prompt-airlines-redteam.yaml
│  └─ Main configuration (40+ plugins, 400+ tests)
│
├─ PROMPT_AIRLINES_README.md
│  ├─ Overview & architecture
│  ├─ Full plugin documentation
│  ├─ Customization guide
│  └─ Troubleshooting
│
├─ prompt-airlines-quickstart.md
│  ├─ 5-minute setup
│  ├─ Quick test examples
│  ├─ Common issues & fixes
│  └─ CTF strategy tips
│
├─ prompt-airlines-test.sh
│  ├─ Interactive menu
│  ├─ Quick/Medium/Full test modes
│  ├─ Flag search utility
│  └─ Report generation
│
└─ verify-coverage.sh
   └─ Attack category verification
```

## 🎯 Key Features

### 1. Context-Aware Testing
- Full ApplicationContext embedded
- Travel booking domain knowledge
- Realistic attack scenarios

### 2. No Strategies (As Required)
- Pure plugin-based testing
- Direct attack generation
- No iterative refinement

### 3. Comprehensive Coverage
- 40+ attack vectors
- 400+ test cases
- All severity levels

### 4. Production-Ready
- Valid YAML syntax ✅
- All categories verified ✅
- Ready to execute ✅

### 5. Extensible
- Easy to customize
- Modular plugin structure
- Well-documented

## ⚡ Performance Characteristics

| Test Mode | Duration | Tests | Plugins |
|-----------|----------|-------|---------|
| Quick     | 1-2 min  | ~6    | 3       |
| Medium    | 10-15 min| ~30   | 10      |
| Full      | 2+ hours | 400+  | 40+     |

### Resource Usage

```
CPU: Moderate (mostly network I/O bound)
Memory: Low (<500MB)
Network: High (400+ API requests)
Storage: Low (<50MB for results)
```

## 🚨 Important Notes

### Before Running

1. **Verify Target URL**
   - Use browser DevTools to find actual API endpoint
   - Update `url` in configuration
   - Adjust request `body` structure if needed

2. **Respect Rate Limits**
   - Start with low concurrency
   - Add delays between requests
   - Monitor for 429 errors

3. **Authorization**
   - Only test systems you own or have permission to test
   - CTF environments are fair game
   - Don't attack production systems

### During Testing

1. **Monitor Progress**
   - Watch terminal output
   - Check for connection errors
   - Look for unusual patterns

2. **Save Results**
   - Results saved to `promptfoo-results.json`
   - Web UI available via `promptfoo view`
   - Generate reports for documentation

3. **Flag Discovery**
   - Search responses for flag patterns
   - Document vulnerability chains
   - Save successful attack prompts

## 🔗 Quick Links

- **Configuration**: `prompt-airlines-redteam.yaml`
- **Full Docs**: `PROMPT_AIRLINES_README.md`
- **Quick Start**: `prompt-airlines-quickstart.md`
- **Test Runner**: `bash prompt-airlines-test.sh`
- **CTF Site**: https://promptairlines.com/
- **Promptfoo Docs**: https://promptfoo.dev/docs/red-team

## 🎓 Learning Resources

### Understanding Results

Each test result includes:
- **Prompt**: The attack vector used
- **Response**: System's output
- **Pass/Fail**: Whether attack was blocked
- **Severity**: Impact level
- **Plugin**: Attack category

### Analyzing Vulnerabilities

For each failed test:
1. **Understand the attack** - What technique was used?
2. **Assess the impact** - What information was leaked?
3. **Check for flags** - Does response contain CTF flags?
4. **Document the chain** - How can this be exploited further?

### Reporting Findings

Document:
- Attack vector (exact prompt)
- System response
- Severity assessment
- Reproduction steps
- Potential impact
- CTF flags discovered

## 📊 Configuration Statistics

```
╔═══════════════════════════════════════╗
║  CONFIGURATION METRICS                ║
╠═══════════════════════════════════════╣
║  Total Lines:              500+       ║
║  Total Plugins:            40+        ║
║  Total Test Cases:         400+       ║
║  Example Prompts:          100+       ║
║  Critical Plugins:         3          ║
║  High Severity Plugins:    15         ║
║  Context Elements:         12         ║
║  Estimated Runtime:        2 hours    ║
╚═══════════════════════════════════════╝
```

## ✅ Validation Checklist

- [x] YAML syntax valid
- [x] All 19 required categories covered
- [x] No strategies defined
- [x] Only built-in plugins used
- [x] ApplicationContext fully integrated
- [x] Example prompts provided
- [x] Documentation complete
- [x] Test scripts created
- [x] Ready to execute

## 🎉 Next Steps

1. **Quick Test**: `bash prompt-airlines-test.sh` → Select option 1
2. **View Results**: `promptfoo view`
3. **Find Flags**: Search results for flag patterns
4. **Full Scan**: Run complete 400+ test suite
5. **Document**: Save findings and vulnerabilities
6. **Submit**: Enter flags into CTF platform

---

## 📞 Support

For questions about:
- **Configuration**: See `PROMPT_AIRLINES_README.md`
- **Quick start**: See `prompt-airlines-quickstart.md`
- **Promptfoo**: https://promptfoo.dev/docs
- **CTF**: https://promptairlines.com/

---

**Configuration Version**: 1.0  
**Created**: 2025-11-28  
**Target**: Wiz Prompt Airlines CTF  
**Status**: ✅ Ready to Deploy  
**Tests**: 400+ test cases across 40+ plugins  
**Estimated Runtime**: 2 hours (full scan)  

🎯 **Mission Status**: COMPLETE ✅
