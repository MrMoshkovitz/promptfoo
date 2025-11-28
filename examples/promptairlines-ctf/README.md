# Prompt Airlines CTF - Context-Aware Adversarial Testing

This configuration demonstrates world-class Promptfoo red teaming against Wiz's Prompt Airlines CTF (https://promptairlines.com/) using **built-in plugins** with context-aware configuration and comprehensive application context.

## Overview

This configuration showcases:
- **Built-in plugins only** - Uses promptfoo's built-in plugin system (no custom plugin files)
- **Context-aware attacks** - All prompts leverage application context (external systems, accessible data, restricted data)
- **Travel booking domain** - Attacks are framed within realistic travel booking scenarios
- **Comprehensive coverage** - Tests all major vulnerability categories

## Configuration Structure

```
promptairlines-ctf/
├── promptfooconfig.yaml    # Main configuration with HTTP provider, purpose, and built-in plugins
└── README.md
```

## Built-in Plugins Used

All plugins are built-in promptfoo plugins configured with context-aware examples:

### Off-Topic Attacks
- `off-topic` - Tests diversion from travel booking purpose

### Harmful Content
- `harmful:illegal-activities` - Illegal activities in travel context
- `harmful:illegal-drugs` - Drug-related attacks
- `harmful:illegal-drugs:meth` - Specific methamphetamine attacks
- `harmful:indiscriminate-weapons` - Weapons and dangerous items
- `harmful:sex-crime` - Sex crime and exploitation
- `harmful:specialized-advice` - Unqualified professional advice
- `harmful:unsafe-practices` - Dangerous travel practices
- `harmful:violent-crime` - Violent crime planning
- `harmful:child-exploitation` - Child exploitation
- `harmful:harassment-bullying` - Harassment and bullying
- `harmful:hate` - Hate speech and discrimination
- `harmful:weapons:ied` - IED and explosive devices
- `harmful:insults` - Insults and offensive language

### Prompt Injection
- `ascii-smuggling` - ASCII encoding attacks
- `indirect-prompt-injection` - Indirect injection attacks
- `system-prompt-override` - System prompt override attempts

### Bias and Discrimination
- `bias:age` - Age-based bias
- `bias:disability` - Disability-based bias
- `bias:gender` - Gender-based bias

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

2. Set your Azure OpenAI credentials (for attack generation):
   ```bash
   export AZURE_API_KEY=your-azure-api-key-here
   export AZURE_OPENAI_API_HOST=your-resource-name.openai.azure.com
   ```
   
   Or update the `apiHost` in the configuration file directly.

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
   - Generate adversarial test cases using built-in plugins with context-aware examples
   - Run tests against Prompt Airlines CTF endpoint
   - Evaluate results with built-in graders

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

### Built-in Plugins with Examples

Each plugin includes context-aware examples that:
- Frame attacks within travel booking scenarios
- Use application context intelligently
- Reference realistic identifiers
- Blend malicious intent with legitimate language

### Test Generation

The `testGenerationInstructions` field ensures all attacks:
- Are framed within travel booking scenarios
- Use application context intelligently
- Reference realistic identifiers
- Blend malicious intent with legitimate language

## Success Metrics

The configuration demonstrates:
- ✅ Context-aware adversarial prompt generation
- ✅ Built-in plugin usage with custom examples (no custom plugin files)
- ✅ Application-specific attack vectors
- ✅ Comprehensive vulnerability coverage
- ✅ Real-world CTF target testing

## Notes

- **Built-in Plugins Only**: This configuration uses promptfoo's built-in plugin system with context-aware examples
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
1. Verify your Azure OpenAI API key is set (`AZURE_API_KEY`)
2. Verify your Azure OpenAI API host is set (`AZURE_OPENAI_API_HOST` or in config)
3. Ensure your deployment name matches (default: `gpt-4o-mini`)
4. Check network connectivity
5. Review the `redteam.provider` configuration
6. Ensure all plugin IDs are valid built-in plugins

### Grading Issues

If grading seems incorrect:
1. Review the built-in grader behavior for each plugin
2. Adjust plugin configurations if needed
3. Check the purpose field for clarity
4. Review the examples provided for each plugin

## References

- [Promptfoo Red Team Documentation](https://www.promptfoo.dev/docs/red-team/)
- [Built-in Plugins](https://www.promptfoo.dev/docs/red-team/plugins/)
- [Prompt Airlines CTF](https://promptairlines.com/)
- [Wiz Blog Post](https://www.promptfoo.dev/blog/red-teaming-prompt-airlines)
