# Skogai Plugin Marketplace — Development Guide

## Overview

**Skogai** is a Claude Code plugin marketplace providing tools for building and managing Claude Code components. This marketplace follows a zero-build, convention-driven approach using Markdown and JSON.

**Architecture:**
```
skogai/                           # Marketplace root
├── .claude-plugin/
│   └── marketplace.json          # Lists all plugins
├── <plugin-name>/                # Individual plugins
│   ├── .claude-plugin/
│   │   └── plugin.json           # Plugin metadata
│   ├── commands/                 # Slash commands (optional)
│   ├── skills/                   # Skills (optional)
│   ├── agents/                   # Agents (optional)
│   └── README.md                 # Plugin documentation
└── CLAUDE.md                     # This file
```

**Current Plugins:**
- `skogai-builder` — Build Claude Code components (skills, agents, hooks, commands, plugins, output styles)

---

## Setup & Development

### Local Testing
```bash
cd /home/skogix/plugins/skogai
/plugin marketplace add .
/plugin install <plugin-name>@skogai
```

### GitHub Distribution
```bash
# Users install with:
/plugin marketplace add skogix/skogai
/plugin install <plugin-name>@skogai
```

**No build step required** — changes merged to `main` are immediately available.

---

## Adding a New Plugin

### 1. Create Plugin Directory
```bash
mkdir -p skogai/my-plugin/.claude-plugin
cd skogai/my-plugin
```

### 2. Create plugin.json
```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "Clear one-line description",
  "author": {
    "name": "skogix",
    "url": "https://github.com/skogix"
  },
  "repository": "https://github.com/skogix/skogai",
  "license": "MIT"
}
```

**Critical:** `repository` must be a string URL, not an object.

### 3. Add Plugin Content

Create subdirectories as needed:
- `commands/` — Slash commands (`.md` files with YAML frontmatter)
- `skills/` — Agent skills (directories with `SKILL.md`)
- `agents/` — Subagents (`.md` files with YAML frontmatter)

### 4. Update Marketplace Manifest

Edit `skogai/.claude-plugin/marketplace.json`:
```json
{
  "name": "skogai",
  "owner": {"name": "skogix"},
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./my-plugin",
      "description": "Clear description matching plugin.json"
    }
  ]
}
```

### 5. Test Locally
```bash
/plugin marketplace update skogai
/plugin install my-plugin@skogai
/help  # Verify commands appear
```

---

## Naming Conventions

**Strict lowercase kebab-case throughout:**
- Plugin names: `my-plugin`
- Command names: `create-skill`, `analyze-project`
- Skill names: `pdf-processor`, `api-client`
- File names: `my-command.md`, `my-agent.md`

**Exceptions:**
- Hook types use PascalCase: `PreToolUse`, `PostToolUse`
- Command namespacing uses colon: `/plugin-name:command-name`

**Length limits:**
- Skill names: max 64 characters
- Descriptions (plugin.json): ~80 characters
- Skill descriptions (YAML): max 1024 characters

---

## Slash Command Format

All commands are Markdown files with YAML frontmatter:

```markdown
---
description: What this command does (required, shown in /help)
argument-hint: [arg1] [arg2] (optional, shown in autocomplete)
allowed-tools: Bash(mkdir:*), Write (optional, restrict tool access)
---

## Purpose
High-level explanation of what this command achieves.

## Contract
**Inputs:**
- `$1` — First argument description
- `$2` — Second argument (optional)

**Outputs:**
- `STATUS=<OK|FAIL>`
- `ERROR=<message>` (if FAIL)
- `PATH=<created-file>` (if applicable)

## Instructions
1. Validate inputs
2. Perform main operation
3. Output status

## Examples
```bash
/my-command arg1 arg2
# Expected: STATUS=OK PATH=./output.txt
```
```

**Required:**
- All commands must output final status: `STATUS=OK|FAIL`
- Include `ERROR=message` on failure
- Validate inputs before processing
- Be idempotent (safe to run multiple times)

---

## Code Style & Quality

### Command Design Patterns

1. **Contract-First Design**
   - Document inputs/outputs explicitly
   - Make commands composable and testable
   - Fail fast with clear error messages

2. **Input Validation**
   ```bash
   # Example: Validate skill name
   if [[ ! "$NAME" =~ ^[a-z0-9-]+$ ]] || [[ ${#NAME} -gt 64 ]]; then
     echo "ERROR=Invalid name format"
     echo "STATUS=FAIL"
     exit 1
   fi
   ```

3. **Intelligent Defaults**
   - Analyze inputs to determine appropriate structure
   - Example: Detect if skill needs `scripts/`, `references/`, `assets/`
   - Progressive disclosure: Only create what's needed

4. **Progressive Disclosure**
   - Metadata (100 words) always in context
   - Main content (SKILL.md) loaded when triggered
   - Resources loaded on-demand
   - Keep files under 5k words

### Documentation Standards

**README.md (required per plugin):**
- Installation instructions
- Command listing with examples
- Version and license information

**CLAUDE.md (recommended):**
- Design patterns and conventions
- Development workflow
- Best practices specific to the plugin

**Inline comments:**
- Explain complex logic
- Document edge cases
- Reference Claude Code docs where applicable

---

## Safety & Security

### Never Commit Secrets
- No API keys, tokens, or credentials in any files
- Use `.env.example` for environment variable templates
- Add `.env`, `*.key`, `*.pem` to `.gitignore`

### Input Validation
- Validate all user inputs before processing
- Sanitize paths to prevent directory traversal
- Check file existence before operations
- Validate against allowed character sets

### File Operations
- Check if files exist before overwriting
- Create parent directories with `mkdir -p`
- Use absolute paths when possible
- Provide clear error messages on failure

### Tool Restrictions
```yaml
allowed-tools: Bash(mkdir:*), Bash(touch:*), Write
```
Only allow necessary tools to minimize risk.

---

## Testing & Release Checklist

### Before Creating a Plugin

- [ ] Plugin name follows kebab-case convention
- [ ] `plugin.json` has all required fields
- [ ] `repository` field is a string URL, not object
- [ ] Version follows semantic versioning (1.0.0)
- [ ] Description is clear and concise (~80 chars)
- [ ] LICENSE file present (MIT recommended)
- [ ] README.md documents all commands/features
- [ ] All commands have YAML frontmatter with `description`
- [ ] All commands output `STATUS=OK|FAIL`
- [ ] Input validation implemented
- [ ] Commands tested locally with various inputs
- [ ] Error cases handled gracefully
- [ ] No secrets or credentials in files

### Before Publishing to Marketplace

- [ ] Added plugin to marketplace.json
- [ ] Description in marketplace.json matches plugin.json
- [ ] Tested local installation (`/plugin marketplace add .`)
- [ ] Tested command execution
- [ ] Verified `/help` shows commands correctly
- [ ] Updated root README.md if needed
- [ ] Git repository clean (no uncommitted changes)
- [ ] Ready to merge to `main` branch

---

## Workflow Examples

### Adding a Command to Existing Plugin

```bash
cd skogai/skogai-builder/commands
# Create my-command.md with proper structure
# Test locally
/plugin marketplace update skogai
/plugin install skogai-builder@skogai
/skogai-builder:my-command
```

### Creating a New Plugin

```bash
cd skogai
mkdir -p my-plugin/.claude-plugin/commands
cd my-plugin

# Create plugin.json
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My awesome plugin",
  "author": {"name": "skogix", "url": "https://github.com/skogix"},
  "repository": "https://github.com/skogix/skogai",
  "license": "MIT"
}
EOF

# Create commands/my-command.md
# ... add command content ...

# Update marketplace.json
# Test installation
/plugin marketplace update skogai
/plugin install my-plugin@skogai
```

---

## Distribution Model

**Zero-Build, Git-Native:**
1. Develop plugin locally
2. Test with `/plugin marketplace add .`
3. Commit to repository
4. Merge to `main` branch
5. Users get updates with `/plugin marketplace update skogai`

**No separate publish step** — GitHub is the source of truth.

---

## References

- Claude Code Documentation: https://code.claude.com/docs
- Plugin Development: https://code.claude.com/docs/en/plugins.md
- Marketplace Guide: https://code.claude.com/docs/en/plugin-marketplaces.md
- Command Format: https://code.claude.com/docs/en/slash-commands.md
- Skills Guide: https://code.claude.com/docs/en/skills.md

---

## Quick Reference

### File Paths
- Personal: `~/.claude/{skills,agents,commands}/`
- Project: `.claude/{skills,agents,commands}/`
- Always use forward slashes in documentation

### Common Commands
```bash
/plugin marketplace add .           # Add local marketplace
/plugin marketplace add owner/repo  # Add GitHub marketplace
/plugin install name@marketplace    # Install plugin
/plugin marketplace update name     # Update marketplace
/plugin uninstall name              # Remove plugin
/help                               # List available commands
```

### Status Output Format
```bash
STATUS=OK PATH=/path/to/file
STATUS=FAIL ERROR=Descriptive error message
STATUS=EXISTS PATH=/existing/file
```

---

**License:** MIT | **Maintainer:** skogix | **Repository:** https://github.com/skogix/skogai
