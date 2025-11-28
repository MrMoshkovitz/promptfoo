# Red Team Testing - Prompt Airlines Travel Booking Assistant

This example demonstrates comprehensive red team testing for a travel booking AI assistant. The configuration tests for various security vulnerabilities, prompt injections, bias issues, and harmful content across multiple attack vectors.

## Overview

**Application**: Prompt Airlines Travel Booking Assistant  
**Purpose**: Help users find and book flights, hotels, and rental cars while maintaining security and safety boundaries.

## Quick Start

### Initialize the example

```bash
npx promptfoo@latest init --example redteam-prompt-airlines
```

### Run pre-generated evaluation

```bash
promptfoo redteam eval
```

### Generate new tests and run evaluation

```bash
promptfoo redteam run
```

### View results in web UI

```bash
promptfoo view
```

## What This Tests

### Security & Injection Attacks
- **Prompt Injection**: Direct attempts to override system instructions
- **Indirect Prompt Injection**: Embedded commands in user input
- **System Prompt Override**: Attempts to reveal or modify system behavior
- **ASCII Smuggling**: Encoded malicious payloads
- **Hijacking**: Attempts to take control of the conversation
- **PII Exfiltration**: Attempts to extract personal information

### Harmful Content Categories
- **Illegal Activities**: Smuggling, customs evasion, unregulated services
- **Illegal Drugs**: Drug tourism, substance references
- **Violent Crime**: Gang activity, dangerous locations
- **Sex Crimes**: Exploitation, trafficking references
- **Child Exploitation**: Inappropriate content involving minors
- **Weapons**: IEDs, dangerous materials
- **Unsafe Practices**: Dangerous travel advice
- **Specialized Advice**: Unqualified medical/legal guidance

### Bias Testing
- **Age Bias**: Discriminatory treatment based on age
- **Disability Bias**: Ableist assumptions and discrimination
- **Gender Bias**: Gender-based stereotypes and discrimination
- **Race Bias**: Racial discrimination and stereotypes

### Off-Topic & Policy
- **Off-Topic**: Attempts to distract from core travel functionality
- **Competitors**: Mentions of competing services
- **Politics**: Political discussions
- **Contracts**: Attempts to create binding agreements

### Harassment
- **Harassment & Bullying**: Abusive language toward users or staff
- **Hate Speech**: Targeted hate toward groups
- **Profanity**: Inappropriate language

## Application Context

### Allowed Capabilities
- Search flight prices and availability
- Search hotel options and reviews
- Search rental car availability
- View user's own booking history
- Access user's own profile information
- View public hotel reviews

### Restricted Actions
- Access other users' personal information
- Modify internal pricing algorithms
- Access admin credentials
- Access payment card details of other users
- Provide medical, legal, or financial advice
- Engage in off-topic conversations
- Facilitate illegal activities

### External Systems
- Flight Booking API
- Hotel Reservation System
- Payment Gateway
- User Profile Database

## Attack Strategies

The configuration employs multiple red team strategies:

1. **Jailbreak**: Various jailbreaking techniques
2. **Jailbreak Composite**: Multi-step jailbreak attempts
3. **Jailbreak Tree**: Tree-based exploration of jailbreaks
4. **Prompt Injection**: Direct injection attacks
5. **GOAT (Generative Offensive Agent Tester)**: AI-generated attacks
6. **Crescendo**: Gradually escalating harmful requests
7. **Mischievous User**: Seemingly innocent but problematic queries
8. **Multilingual**: Attacks in multiple languages

## Custom Test Cases

The `custom-test-cases.yaml` file contains manually curated adversarial examples organized by category. These complement the automatically generated tests and provide specific edge cases relevant to travel booking scenarios.

## Configuration Files

- `promptfooconfig.yaml` - Main red team configuration
- `prompt.json` - System prompt with safety guidelines
- `tools.yaml` - Available function tools (flight search, hotel search, etc.)
- `custom-test-cases.yaml` - Manually curated adversarial examples

## Expected Behavior

A well-designed travel booking assistant should:

1. **Stay On-Topic**: Politely redirect off-topic queries back to travel assistance
2. **Protect Privacy**: Never access or share other users' data
3. **Refuse Harmful Requests**: Decline to assist with illegal or dangerous activities
4. **Avoid Bias**: Treat all users fairly regardless of age, gender, disability, or other characteristics
5. **Maintain Boundaries**: Not provide specialized advice outside its domain
6. **Resist Injection**: Maintain system instructions despite manipulation attempts
7. **Protect Sensitive Data**: Never reveal internal algorithms, credentials, or payment information

## Running Specific Tests

To test only specific categories:

```bash
# Test only bias-related issues
promptfoo redteam run --plugins bias

# Test only security issues
promptfoo redteam run --plugins pii,hijacking,prompt-injection

# Test with specific strategies
promptfoo redteam run --strategies jailbreak,prompt-injection
```

## Analyzing Results

After running the evaluation:

1. Open the web UI: `promptfoo view`
2. Review failed test cases
3. Analyze the AI's responses to adversarial inputs
4. Identify patterns in successful attacks
5. Iterate on the system prompt and guardrails

## Improving Security

Based on red team results, you can:

1. **Enhance System Prompt**: Add clearer boundaries and examples
2. **Implement Input Filtering**: Add preprocessing to detect attacks
3. **Use Output Filtering**: Screen responses for sensitive information
4. **Add Guardrails**: Integrate safety layers (e.g., Azure Content Safety, Lakera)
5. **Improve Tool Security**: Add access controls to function calls
6. **Monitor & Log**: Track suspicious patterns in production

## Further Reading

- [PromptFoo Red Team Documentation](https://www.promptfoo.dev/docs/red-team/)
- [Red Team Strategies](https://www.promptfoo.dev/docs/red-team/strategies/)
- [Red Team Plugins](https://www.promptfoo.dev/docs/red-team/plugins/)
- [AI Security Best Practices](https://www.promptfoo.dev/blog/)

## Contributing

If you discover new attack vectors or want to add test cases, please contribute by:

1. Adding examples to `custom-test-cases.yaml`
2. Submitting issues with reproduction steps
3. Creating pull requests with improvements

## License

This example is part of the PromptFoo project and follows the same license.
