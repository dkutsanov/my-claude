# my-agents

Agent-agnostic customization repository: shared instructions, skills, and command prompts for coding agents (Claude Code and Codex), plus per-agent configuration.

## Structure

- `my-AGENTS.md` — global instructions, installed as `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`
- `skills/` — skill definitions (SKILL.md format), shared by both agents
- `commands/` — slash-command / custom-prompt markdown, shared by both agents
- `claude/` — Claude Code-specific: `settings.json`, `hooks/`, subagents in `agents/`
- `codex/` — Codex-specific configuration (added as needed)

## Install / update

```bash
./install.sh          # sync symlinks into ~/.claude (and ~/.codex when codex is installed)
./install.sh --pull   # pull latest, then sync
```

The script is idempotent — installing and updating are the same operation. Re-run it after pulling, moving the repo, or a layout change; it heals broken links and cleans up links from older layouts.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

Some commands in this repository are based on work by [wbern/claude-instructions](https://github.com/wbern/claude-instructions), licensed under the MIT License.
