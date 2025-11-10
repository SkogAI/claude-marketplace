# Skogai Plugin Marketplace — Development Guide

## Overview

**Skogai** is a Claude Code plugin marketplace providing tools for building and managing Claude Code components. This marketplace follows a zero-build, convention-driven approach using Markdown and JSON.

**Architecture:**
```
skogai/                           # Marketplace root
├── .claude-plugin/
│   └── marketplace.json          # Lists all plugins in marketplace
├── CLAUDE.md                     # Development guide (this file)
├── README.md                     # Marketplace overview
└── <plugin-name>/                # Individual plugin directory
    ├── .claude-plugin/           # Plugin definition (required)
    │   ├── plugin.json           # Plugin metadata (required)
    │   └── marketplace.json      # Optional: Plugin can also be a marketplace
    ├── agents/                   # Subagents (optional)
    ├── commands/                 # Slash commands (optional)
    ├── hooks/                    # Lifecycle hooks (optional)
    ├── output-styles/            # Output formatters (optional)
    ├── CLAUDE.md                 # Plugin-specific development docs
    ├── README.md                 # Plugin documentation
    ├── settings.json             # Plugin settings/preferences
    └── SKOGIX.md                 # User-writable notes (gitignored)
```

**Current Plugins:**
- `skogai-builder` — Build Claude Code components (skills, agents, hooks, commands, plugins, output styles)
- `hello-world` — Demo plugin created with skogai-builder showcasing all component types (commands, agents, hooks, output-styles, skills)

## Understanding Claude Code Plugin Structure

### Plugin Structure vs Project Structure

**IMPORTANT:** Plugins have a different structure from project customizations!

**Plugins** (for distribution):
```
my-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin metadata ONLY
│   └── marketplace.json     # Marketplace manifest (for marketplace root)
├── commands/                 # ← At PLUGIN ROOT (not .claude/commands/)
├── agents/                   # ← At PLUGIN ROOT (not .claude/agents/)
├── hooks/                    # ← At PLUGIN ROOT (not .claude/hooks/)
├── output-styles/            # ← At PLUGIN ROOT (not .claude/output-styles/)
├── settings.json             # ← At PLUGIN ROOT (defines plugin hooks)
└── README.md
```

**Project/User Customizations** (NOT plugins):
```
./.claude/                    # ← Project level
~/.claude/                    # ← User level
```


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

## Documentation Standards

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

## Testing & Release Checklist

### Before Creating a Plugin

@docs/checklists/plugin.list

### Before Publishing to Marketplace

@docs/checklists/marketplace.list

## References

- The `/docs` command

## Common Mistakes to Avoid

❌ **DO NOT** put plugin files in `.claude/` subdirectories:
- `.claude/commands/` - WRONG for plugins
- `.claude/agents/` - WRONG for plugins
- `.claude/settings.json` - WRONG for plugins

✅ **DO** put plugin files at the plugin root:
- `commands/` - CORRECT
- `agents/` - CORRECT
- `settings.json` - CORRECT

❌ **DO NOT** use `$CLAUDE_PROJECT_DIR` in plugin hooks

✅ **DO** use `${CLAUDE_PLUGIN_ROOT}` in plugin hooks

## Important files and folders

- @docs/ - the general documentation for meta information (not included in the actual plugins)
