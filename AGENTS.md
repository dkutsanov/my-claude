# AGENTS.md

Guidance for coding agents working on this repository. `CLAUDE.md` is a symlink to this file.

## Repository Purpose

Agent-agnostic customization repository: shared instructions, skills, and command prompts for Claude Code and Codex, plus per-agent configuration. `install.sh` symlinks the content into `~/.claude` and `~/.codex`.

## Structure

- `my-AGENTS.md` — global instructions, installed as `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`
- `skills/` — skill definitions (SKILL.md format), shared by both agents
- `commands/` — slash-command / custom-prompt markdown, shared by both agents
- `claude/` — Claude Code-specific: `settings.json`, `hooks/`, subagents in `agents/`
- `codex/` — Codex-specific configuration (added as needed)

## Where things go

- Shared content (skills, commands, `my-AGENTS.md`) lives at the repo root. Keep its wording tool-neutral where reasonable — e.g. "ask the user" rather than naming a Claude-specific tool — so it degrades gracefully under other agents.
- Anything only one agent understands (settings, hooks, subagents, config.toml) goes under `claude/` or `codex/`.
- Create new commands in `commands/` at the repo root, never directly in `~/.claude/` or `~/.codex/` — those are symlinks managed by `install.sh`.
- After adding or removing top-level entries, update `install.sh` accordingly and re-run it.
