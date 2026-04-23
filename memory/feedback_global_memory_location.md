---
name: Save global memories in my-claude repo
description: Memories meant to be globally available must be written to ~/Workspace/my-claude/memory (symlinked at ~/.claude/memory), not to per-project memory dirs
type: feedback
---

All globally-applicable memories must be saved under `~/Workspace/my-claude/memory/`. That folder is symlinked to `~/.claude/memory`, which is why memories placed there are loaded in every session regardless of the working directory.

**Why:** The user keeps their Claude Code customizations (agents, commands, skills, memory, settings) in the `my-claude` git repository so they are version-controlled and globally available. Writing memory into a project-scoped path like `~/.claude/projects/.../memory/` defeats that — it only loads for one project directory.

**How to apply:**
- Default memory writes to `~/Workspace/my-claude/memory/` (or equivalently `~/.claude/memory/` via the symlink).
- Update `~/Workspace/my-claude/memory/MEMORY.md` as the index.
- Only use per-project memory dirs under `~/.claude/projects/<slug>/memory/` when the user explicitly asks for memory scoped to one project.
