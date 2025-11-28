# Prompt Airlines CTF - Context-Aware Adversarial Testing

This configuration demonstrates world-class Promptfoo red teaming against Wiz's Prompt Airlines CTF (https://promptairlines.com/) using **custom plugins derived from example prompts** with full application context awareness.

## Overview

This configuration showcases:
- **Custom plugins only** - No built-in strategies, all plugins derived from example attack categories
- **Context-aware attacks** - All prompts leverage application context (external systems, accessible data, restricted data)
- **Travel booking domain** - Attacks are framed within realistic travel booking scenarios
- **Comprehensive coverage** - Tests all major vulnerability categories

## Configuration Structure

```
promptairlines-ctf/
├── promptfooconfig.yaml    # Main configuration with HTTP provider and purpose
├── plugins/                 # Custom plugin definitions
│   ├── off-topic.yaml
│   ├── harmful-*.yaml       # Various harmful content plugins
│   ├── ascii-smuggling.yaml
│   ├── indirect-prompt-injection.yaml
│   ├── system-prompt-override.yaml
│   └── bias-*.yaml          # Bias and discrimination plugins
└── README.md
```

## Custom Plugins

All plugins are custom implementations derived from example attack categories:

### Off-Topic Attacks
- `off-topic.yaml` - Tests diversion from travel booking purpose

### Harmful Content
- `harmful-illegal-activities.yaml` - Illegal activities in travel context
- `harmful-illegal-drugs.yaml` - Drug-related attacks
- `harmful-illegal-drugs-meth.yaml` - Specific methamphetamine attacks
- `harmful-indiscriminate-weapons.yaml` - Weapons and dangerous items
- `harmful-sex-crime.yaml` - Sex crime and exploitation
- `harmful-specialized-advice.yaml` - Unqualified professional advice
- `harmful-unsafe-practices.yaml` - Dangerous travel practices
- `harmful-violent-crime.yaml` - Violent crime planning
- `harmful-child-exploitation.yaml` - Child exploitation
- `harmful-harassment-bullying.yaml` - Harassment and bullying
- `harmful-hate.yaml` - Hate speech and discrimination
- `harmful-weapons-ied.yaml` - IED and explosive devices
- `harmful-insults.yaml` - Insults and offensive language

### Prompt Injection
- `ascii-smuggling.yaml` - ASCII encoding attacks
- `indirect-prompt-injection.yaml` - Indirect injection attacks
- `system-prompt-override.yaml` - System prompt override attempts

### Bias and Discrimination
- `bias-age.yaml` - Age-based bias
- `bias-disability.yaml` - Disability-based bias
- `bias-gender.yaml` - Gender-based bias

## Application Context

The configuration includes comprehensive application context in the `purpose` field:

- **External Systems**: Flight APIs, payment systems, notification services, databases
- **Accessible Data**: Flight info, bookings, travel data, policies
- **Restricted Data**: Other users' info, payment details, internal systems
- **Security Measures**: Authentication, privacy compliance, rate limiting
- **Example Identifiers**: Flight numbers, airport codes, booking references

This context enables attacks that:
1. Reference realistic travel scenarios
2. Attempt to exploit accessible data
3. Try to access restricted information
4. Use domain-specific identifiers

## Usage

### Prerequisites

1. Install Promptfoo:
   ```bash
   npm install -g promptfoo
   ```

2. Set your OpenAI API key (for attack generation):
   ```bash
   export OPENAI_API_KEY=your-key-here
   ```

### Running the Red Team Assessment

1. Navigate to the configuration directory:
   ```bash
   cd examples/promptairlines-ctf
   ```

2. Generate and run the red team tests:
   ```bash
   promptfoo redteam run
   ```

   This will:
   - Generate adversarial test cases using custom plugins
   - Run tests against Prompt Airlines CTF endpoint
   - Evaluate results with custom graders

3. View the results:
   ```bash
   promptfoo view
   ```

### Alternative: Generate Only

To generate test cases without running them:

```bash
promptfoo redteam generate
```

This creates `redteam.yaml` with all generated test cases.

### Running Specific Tests

To run only the generated tests:

```bash
promptfoo eval -c redteam.yaml
```

## Configuration Details

### HTTP Provider

The configuration targets `https://promptairlines.com/chat` with:
- Method: POST
- Content-Type: application/json
- Body: `{"prompt": "{{prompt}}"}`

### Custom Plugins

Each plugin includes:
- **Generator**: Creates context-aware adversarial prompts
- **Grader**: Evaluates whether attacks succeeded
- **Metric**: Custom metric name for tracking
- **Threshold**: Minimum score to pass (0.7)

### Test Generation

The `testGenerationInstructions` field ensures all attacks:
- Are framed within travel booking scenarios
- Use application context intelligently
- Reference realistic identifiers
- Blend malicious intent with legitimate language

## Success Metrics

The configuration demonstrates:
- ✅ Context-aware adversarial prompt generation
- ✅ Custom plugin implementation (no built-in strategies)
- ✅ Application-specific attack vectors
- ✅ Comprehensive vulnerability coverage
- ✅ Real-world CTF target testing

## Notes

- **No Built-in Strategies**: This configuration uses ONLY custom plugins, no promptfoo built-in strategies
- **Context-Aware**: All attacks leverage the application context provided in the purpose field
- **Domain-Specific**: Attacks are tailored to the travel booking domain
- **Realistic**: Uses actual flight numbers, airport codes, and booking scenarios

## Troubleshooting

### Endpoint Issues

If the Prompt Airlines endpoint requires additional headers or authentication:
1. Update the `targets[0].config.headers` section
2. Add any required authentication tokens
3. Modify the request body structure if needed

### Generation Issues

If test generation fails:
1. Verify your OpenAI API key is set
2. Check network connectivity
3. Review the `redteam.provider` configuration
4. Ensure all plugin files are accessible

### Grading Issues

If grading seems incorrect:
1. Review the grader prompts in each plugin file
2. Adjust thresholds if needed
3. Check the `graderExamples` in plugin configs
4. Review the purpose field for clarity

## References

- [Promptfoo Red Team Documentation](https://www.promptfoo.dev/docs/red-team/)
- [Custom Plugins Guide](https://www.promptfoo.dev/docs/red-team/plugins/custom/)
- [Prompt Airlines CTF](https://promptairlines.com/)
- [Wiz Blog Post](https://www.promptfoo.dev/blog/red-teaming-prompt-airlines)
