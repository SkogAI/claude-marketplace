# Skogai Plugin Marketplace

A collection of Claude Code plugins for enhanced development workflows.

## Installation

### From GitHub (when published)
```bash
/plugin marketplace add skogix/skogai
/plugin install <plugin-name>@skogai
```

### Local Development
```bash
cd /path/to/skogai
/plugin marketplace add .
/plugin install <plugin-name>@skogai
```

## Available Plugins

### skogai-builder
Build Claude Code components including skills, agents, hooks, slash commands, plugins, and output styles.

**Commands:**
- `/skogai-builder:create-skill` - Generate Agent Skills with proper structure
- `/skogai-builder:create-agent` - Create subagents with focused roles
- `/skogai-builder:create-command` - Generate new slash commands
- `/skogai-builder:create-hook` - Configure event-driven hooks
- `/skogai-builder:create-plugin` - Package .claude/ setup into distributable plugin
- `/skogai-builder:create-md` - Generate CLAUDE.md files for project awareness
- `/skogai-builder:create-output-style` - Create custom Output Styles

**Installation:**
```bash
/plugin install skogai-builder@skogai
```

## Adding New Plugins

To add a new plugin to this marketplace:

1. Create a new directory under `skogai/`
2. Add `.claude-plugin/plugin.json` with plugin metadata
3. Add your plugin content (commands, skills, agents, etc.)
4. Update `skogai/.claude-plugin/marketplace.json` to include your plugin:
   ```json
   {
     "name": "your-plugin-name",
     "source": "./your-plugin-name",
     "description": "Brief description of your plugin"
   }
   ```

## Plugin Structure

```
skogai/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest
├── plugin-name/                  # Individual plugin
│   ├── .claude-plugin/
│   │   └── plugin.json          # Plugin metadata
│   ├── commands/                # Slash commands (optional)
│   ├── skills/                  # Skills (optional)
│   ├── agents/                  # Agents (optional)
│   └── README.md
└── README.md                    # This file
```

## License

MIT
