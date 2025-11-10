# Hello-World Plugin — Development Guide

## Overview

**hello-world** is a demonstration Claude Code plugin showcasing core extensibility features through a simple greeting theme. It serves as a reference implementation for building Claude Code plugins with:

- **Slash Commands** — Custom CLI commands (`/hello-world`)
- **Specialized Agents** — Task-specific subagents (`hello-world-agent`)
- **Output Styles** — Custom personas (`hello-greeter`)
- **Session Hooks** — Lifecycle automation (`hello-session.sh`)

**Architecture:**
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
```

---

## Components

### 1. Slash Command: `/hello-world [name]`

**Purpose:** Generate personalized greetings with optional name argument.

**Usage:**
```bash
/hello-world           # Greets "friend"
/hello-world Alice     # Greets "Alice"
```

**Implementation Pattern:**
- Markdown file with YAML frontmatter
- `description` (required) — shown in `/help`
- `argument-hint` (optional) — shown in autocomplete
- Command body contains instructions for Claude

**Location:** `.claude/commands/hello-world.md`

### 2. Specialized Agent: `hello-world-agent`

**Purpose:** Generate "Hello World" examples in any programming language or framework.

**Usage:**
```bash
# Invoke via Task tool
"Create a hello world example in Python"
"Show me a React hello world"
```

**Capabilities:**
- Language/framework detection
- Minimal working examples
- Setup instructions
- Convention-following code

**Location:** `.claude/agents/hello-world-agent.md`

### 3. Output Style: `hello-greeter`

**Purpose:** Custom response personality mimicking a "Hello World" application.

**Activation:**
```bash
/output-style hello-greeter
```

**Characteristics:**
- Enthusiastic, beginner-friendly tone
- Uses exclamation marks liberally
- Simplifies technical concepts
- Maintains accuracy while being welcoming

**Location:** `.claude/output-styles/hello-greeter.md`

### 4. Session Hook: `hello-session.sh`

**Purpose:** Print session ID on startup.

**Trigger:** SessionStart (configured in `settings.json`)

**Output:**
```bash
hello world <SESSION_ID>
```

**Location:** `.claude/hooks/hello-session.sh`

---

## Development Workflow

### Testing Components Locally

**Commands:**
```bash
/hello-world          # Test slash command
/help                 # Verify command appears in help
```

**Agents:**
- Create a task that matches agent specialization
- Agent should be automatically suggested/used

**Output Styles:**
```bash
/output-style hello-greeter    # Activate persona
/output-style default          # Deactivate
```

**Hooks:**
- Restart Claude Code session
- Check for "hello world <SESSION_ID>" output

### Making Changes

1. **Edit component files** in `.claude/`
2. **Reload session** (restart Claude Code or `/clear`)
3. **Test changes** using methods above
4. **Commit to git** (zero-build architecture)

---

## Naming Conventions

**Strict kebab-case throughout:**
- Command names: `hello-world`, `my-command`
- Agent names: `hello-world-agent`, `code-reviewer`
- Output style names: `hello-greeter`, `technical-writer`
- File names: `hello-world.md`, `my-agent.md`

**Required YAML frontmatter fields:**
- Commands: `description` (required), `argument-hint` (optional)
- Agents: `name`, `description`
- Output Styles: `name`, `description`

---

## Converting to Distributable Plugin

To package hello-world as a marketplace plugin:

### 1. Create Plugin Manifest

**File:** `.claude-plugin/plugin.json`
```json
{
  "name": "hello-world",
  "version": "1.0.0",
  "description": "Demonstration plugin showcasing Claude Code features",
  "author": {
    "name": "skogix",
    "url": "https://github.com/skogix"
  },
  "repository": "https://github.com/skogix/skogai",
  "license": "MIT"
}
```

### 2. Add to Marketplace

**File:** `../skogai/.claude-plugin/marketplace.json`
```json
{
  "plugins": [
    {
      "name": "hello-world",
      "source": "./hello-world",
      "description": "Demonstration plugin showcasing Claude Code features"
    }
  ]
}
```

### 3. Create Documentation

**File:** `README.md`
- Installation instructions
- Component listing with examples
- Usage guide

### 4. Test Installation

```bash
cd /home/skogix/plugins/skogai
/plugin marketplace add .
/plugin install hello-world@skogai
```

---

## Code Style & Patterns

### Command Design Pattern

```markdown
---
description: Brief description for /help
argument-hint: [optional-arg]
---

## Purpose
What this command achieves.

## Instructions
Step-by-step guide for Claude.

## Examples
```bash
/my-command example
```
```

### Agent Design Pattern

```markdown
---
name: agent-name
description: Clear specialization (max 1024 chars)
---

# Agent Name

## Specialization
What this agent excels at.

## Available Tools
- Tool1
- Tool2

## Instructions
Detailed step-by-step behavior.

## Examples
Usage scenarios.
```

### Output Style Pattern

```markdown
---
name: style-name
description: Persona description
---

# Style Name

## Personality
Key characteristics.

## Response Guidelines
- Guideline 1
- Guideline 2

## Examples
Sample responses.
```

---

## Safety & Best Practices

### Never Commit Secrets
- No API keys or credentials in any files
- Use `.env.example` for environment templates
- Add `.env`, `*.key`, `*.pem` to `.gitignore`

### Input Validation
- Validate user inputs in commands
- Handle missing arguments gracefully
- Provide clear error messages

### Hook Safety
- Keep hooks lightweight (run on every session)
- Avoid long-running operations
- Print minimal, useful output
- Use `set -euo pipefail` for Bash scripts

---

## Extension Guidelines

### Adding a New Command

1. Create `.claude/commands/my-command.md`
2. Add YAML frontmatter with `description`
3. Write clear instructions for Claude
4. Include usage examples
5. Test with `/my-command`

### Adding a New Agent

1. Create `.claude/agents/my-agent.md`
2. Define clear specialization
3. List available tools
4. Write detailed instructions
5. Test by triggering matching tasks

### Adding a New Output Style

1. Create `.claude/output-styles/my-style.md`
2. Define personality characteristics
3. Provide response guidelines
4. Include example outputs
5. Test with `/output-style my-style`

### Adding a New Hook

1. Create `.claude/hooks/my-hook.sh`
2. Add to `settings.json` under appropriate lifecycle event
3. Keep script minimal and fast
4. Output only essential information
5. Test by restarting session

---

## Troubleshooting

### Command Not Appearing in /help
- Check YAML frontmatter has `description` field
- Verify file is in `.claude/commands/`
- Restart Claude Code session

### Agent Not Being Used
- Check agent specialization matches task
- Verify YAML frontmatter has `name` and `description`
- File must be in `.claude/agents/`

### Hook Not Running
- Check `settings.json` hook configuration
- Verify matcher pattern (`*` matches all projects)
- Ensure script is executable: `chmod +x .claude/hooks/*.sh`

### Output Style Not Activating
- Verify YAML frontmatter has `name` and `description`
- File must be in `.claude/output-styles/`
- Use exact name: `/output-style hello-greeter`

---

## Quick Reference

### File Locations
- Commands: `.claude/commands/*.md`
- Agents: `.claude/agents/*.md`
- Output Styles: `.claude/output-styles/*.md`
- Hooks: `.claude/hooks/*.sh`
- Settings: `.claude/settings.json`

### Testing Commands
```bash
/hello-world Alice       # Test command
/help                    # Verify command listed
/output-style hello-greeter  # Activate style
```

### Hook Lifecycle Events
- `SessionStart` — Session begins
- `SessionEnd` — Session ends
- `PreToolUse` — Before tool execution
- `PostToolUse` — After tool execution
- `UserPromptSubmit` — User submits message

---

## References

- [Claude Code Documentation](https://code.claude.com/docs)
- [Plugin Development](https://code.claude.com/docs/en/plugins.md)
- [Slash Commands](https://code.claude.com/docs/en/slash-commands.md)
- [Agents](https://code.claude.com/docs/en/agents.md)
- [Output Styles](https://code.claude.com/docs/en/output-styles.md)
- [Hooks](https://code.claude.com/docs/en/hooks.md)

---

**License:** MIT | **Maintainer:** skogix | **Repository:** https://github.com/skogix/skogai
