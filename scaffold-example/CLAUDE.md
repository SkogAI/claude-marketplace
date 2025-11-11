# scaffold-example plugin

This is a basic scaffold showing the minimal structure for a Claude Code plugin.

## Structure

```
scaffold-example/
├── .claude-plugin/
│   ├── plugin.json          # Plugin metadata
│   └── marketplace.json     # Marketplace listing
├── commands/                # Slash commands (.md files)
├── skills/                  # Skills with YAML frontmatter
├── agents/                  # Custom subagents (.md files)
├── hooks/                   # Pre/post tool execution hooks
├── output-styles/           # Custom output style prompts
├── settings.json            # Plugin settings
├── CLAUDE.md               # This file - instructions for Claude
└── README.md               # User-facing documentation
```

## What this plugin does

Nothing yet - it's a scaffold. Use it as a template for creating new plugins.

## How to extend

Add files to any of the component directories:
- `commands/*.md` - Create custom slash commands
- `skills/*/SKILL.md` - Create skills with references and assets
- `agents/*.md` - Define specialized subagents
- `hooks/*.md` - Add pre/post hooks for tool execution
- `output-styles/*.md` - Create custom output style prompts
