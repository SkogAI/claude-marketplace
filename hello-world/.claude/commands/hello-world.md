---
description: takes a name as a input and expects claude to return a improvised hello <name>-response
argument-hint: [name]
---

# /hello-world

## Purpose
Takes a name as input and expects Claude to return an improvised hello <name>-response.

## Contract
**Inputs:** `$1` — NAME (the name to greet)
**Outputs:** An improvised, friendly greeting message

## Instructions

1. **Validate inputs:**
   - Check that a name argument is provided
   - If no name provided, use "friend" as default

2. **Generate improvised greeting:**
   - Create a unique, friendly greeting for the provided name
   - Be creative and vary the greeting style each time
   - Keep it warm, welcoming, and appropriate

3. **Respond naturally:**
   - No STATUS lines needed - this is a conversational command
   - Just deliver the improvised greeting directly

## Examples

```bash
/hello-world Alice
# Example response: "Well hello there, Alice! What a fantastic name - it reminds me of adventures through looking glasses and down rabbit holes. How can I help you today?"

/hello-world Bob
# Example response: "Hey Bob! Great to see you! Ready to dive into some code together?"

/hello-world
# Example response: "Hello, friend! Welcome! What shall we build today?"
```

## Constraints
- Keep greetings appropriate and professional
- Vary the style to keep responses fresh
- Default to "friend" if no name provided
