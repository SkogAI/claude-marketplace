# Hello-World Plugin

A demonstration Claude Code plugin showcasing core extensibility features through a simple greeting theme.

## Features

### 1. Slash Command: `/hello-world`
Generate personalized greetings with optional name argument.

```bash
/hello-world           # Greets "friend"
/hello-world Alice     # Greets "Alice" with improvised greeting
```

### 2. Specialized Agent: `hello-world-agent`
Automatically generates "Hello World" examples in any programming language or framework.

```bash
# Examples that trigger the agent:
"Create a hello world in Python"
"Show me a React hello world"
"What's a basic hello world server in Go"
```

### 3. Output Style: `hello-greeter`
Custom response persona that mimics the enthusiastic simplicity of a "Hello World" application.

```bash
/output-style hello-greeter    # Activate persona
/output-style default          # Deactivate
```

### 4. Session Hook: `hello-session.sh`
Prints session ID on startup for demonstration purposes.

```bash
# Output on session start:
hello world <SESSION_ID>
```

## Installation

### Local Development/Testing

```bash
cd /path/to/hello-world
claude

# Inside Claude Code:
/plugin marketplace add .
/plugin install hello-world@hello-world
```

### From GitHub (when published)

```bash
# Inside Claude Code:
/plugin marketplace add skogix/skogai
/plugin install hello-world@skogai
```

## Usage Examples

### Command Usage
```bash
# Basic greeting
/hello-world
# Output: "Hello, friend! Welcome! What shall we build today?"

# Named greeting
/hello-world Sarah
# Output: "Well hello there, Sarah! What a fantastic name..."
```

### Agent Usage
The agent automatically activates when you request "Hello World" examples:

```bash
# Request in natural language
"I need a hello world example in Rust"
"Show me how to create a hello world React component"
"Create a minimal Express.js hello world server"
```

### Output Style Usage
```bash
# Activate the Hello Greeter persona
/output-style hello-greeter

# Ask any question - responses will be enthusiastic and beginner-friendly
"How do I create a function?"
# Response: "Hello! Oh, functions are wonderful! Let me show you..."

# Deactivate
/output-style default
```

### Hook Behavior
The session hook automatically runs on startup and prints:
```
hello world <your-session-id>
```

## Component Structure

```
hello-world/
├── .claude/
│   ├── settings.json              # Hook configuration
│   ├── commands/
│   │   └── hello-world.md         # /hello-world command
│   ├── agents/
│   │   └── hello-world-agent.md   # Specialized agent
│   ├── output-styles/
│   │   └── hello-greeter.md       # Custom persona
│   └── hooks/
│       └── hello-session.sh       # SessionStart hook
├── .claude-plugin/
│   ├── plugin.json                # Plugin metadata
│   └── marketplace.json           # Marketplace manifest
├── CLAUDE.md                      # Development guide
└── README.md                      # This file
```

## Development

### Testing Components Locally

1. **Test slash command:**
   ```bash
   /hello-world Alice
   /help  # Verify command appears
   ```

2. **Test agent:**
   - Create a task requesting a "Hello World" example
   - Agent should automatically be suggested/used

3. **Test output style:**
   ```bash
   /output-style hello-greeter
   # Ask a question and observe the enthusiastic tone
   /output-style default
   ```

4. **Test hook:**
   - Restart Claude Code session
   - Look for "hello world <SESSION_ID>" output

### Making Changes

1. Edit component files in `.claude/`
2. Reload session (restart Claude Code or `/clear`)
3. Test changes
4. Commit to git (zero-build architecture)

## Use as Reference

This plugin serves as a reference implementation for:

- **Plugin structure** — How to organize a Claude Code plugin
- **Slash commands** — YAML frontmatter and markdown format
- **Specialized agents** — Agent definition and specialization
- **Output styles** — Custom persona creation
- **Session hooks** — Lifecycle automation with Bash scripts
- **Marketplace setup** — Both plugin.json and marketplace.json

## Contributing

This is a demonstration plugin. For issues or suggestions:
- Open an issue at [skogix/skogai](https://github.com/skogix/skogai)
- Follow the contribution guidelines in the main repository

## License

MIT

## References

- [Claude Code Documentation](https://code.claude.com/docs)
- [Plugin Development Guide](https://code.claude.com/docs/en/plugins.md)
- [Marketplace Guide](https://code.claude.com/docs/en/plugin-marketplaces.md)
- [Slash Commands](https://code.claude.com/docs/en/slash-commands.md)
- [Agents](https://code.claude.com/docs/en/agents.md)
- [Output Styles](https://code.claude.com/docs/en/output-styles.md)
- [Hooks](https://code.claude.com/docs/en/hooks.md)
