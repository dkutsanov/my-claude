---
name: commit
description: Create one or more git commits following project standards. Use when the user asks to commit, or after completing a task that produces code changes ready to commit. Supports two modes — a single commit covering all pending changes (default) and an atomic mode that creates one commit per logical change. Do NOT use when the user only asks to review, diff, or check status without committing.
---

# Git Commit

Create git commits following project standards. Apply the **Shared Rules** plus **exactly one** Mode section per invocation — do not apply both modes at once.

## Mode Dispatch

Read the first whitespace-delimited token of `$ARGUMENTS`:

- First token matches `atomic`, `busy`, `multi`, or `many` (case-insensitive) → `MODE = atomic`
- Otherwise → `MODE = single` (the default; treat any remaining args as optional description hints, not a pre-formed commit message)

State the chosen mode in one short line before acting:

```
Committing in <MODE> mode.
```

Then apply **Shared Rules** plus the matching **Mode: <MODE>** section.

## Shared Rules

### Commit Message Rules

1. **Format — project convention wins.** Check the repo's `CLAUDE.md` and `git log --oneline -5` for the message convention (e.g. `[JIRA-ID] Description` in sysdig repos) and use it verbatim. Only when the repo shows no convention, default to [Conventional Commits](https://www.conventionalcommits.org/): `type(#issue): description` with `#123` for local issues, `owner/repo#123` cross-repo; common types `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.

2. **No AI attribution**: NEVER add `Co-Authored-By` trailer lines to commit messages (e.g. `Co-Authored-By: Claude <...>`). The user does not want AI attribution in git history. This rule applies whether you invoke this skill or fall back to a raw `git commit` command. Also never include "Generated with Claude Code" or similar.

3. **Content**: Write clear, concise commit messages describing what changed and why. Focus on the actual changes, not conversation history.

### Pre-commit Checks (both modes)

1. Run `git status` — confirm what's staged vs unstaged vs untracked
2. Run `git diff` (and `git diff --cached` if staged changes exist) — review the actual changes
3. Run `git log --oneline -5` — match the repo's recent commit style
4. Do NOT commit files that likely contain secrets (`.env`, credentials, keys, tokens). Warn the user if they specifically request those files.

---

## Mode: single

**Apply this section only if MODE == single.** If MODE is anything else, skip this section entirely.

Create ONE commit containing all the currently pending changes that belong together.

### Process

1. Complete the pre-commit checks above
2. Stage relevant files with `git add <specific files>` (prefer explicit paths over `git add -A` / `git add .` to avoid accidentally including unrelated work or secrets)
3. Create the commit with a descriptive message in the repo's format
4. Run `git status` to verify the commit landed cleanly

### Example

```bash
git add src/user-service.ts src/user-service.test.ts
git commit -m "feat(#123): add email format validation"
git status
```

---

## Mode: atomic

**Apply this section only if MODE == atomic.** If MODE is anything else, skip this section entirely.

Create MULTIPLE atomic commits, one per logical change. Each commit should represent ONE logical change — do NOT bundle unrelated changes into a single commit.

### Process

1. Complete the pre-commit checks above
2. Identify the smallest atomic units of change across the diff
3. For EACH atomic unit:
   - Stage only the files/hunks for that unit (use `git add <file>` for whole-file changes, `git add -p <file>` to stage partial hunks when a file has multiple logical changes)
   - Create a message for that unit in the repo's format
   - Verify with `git status` that the commit landed
4. Keep going without stopping until `git status` shows a clean tree
5. At the end, summarize the commits created (short list of `git log --oneline` since the start)

### Multi-commit Example

If a single file contains multiple unrelated changes:

```bash
# Stage only the validation-related hunks
git add -p src/user-service.ts
# (select 'y' for validation hunks, 'n' for others)
git commit -m "feat(#123): add email format validation"

# Stage the error handling hunks
git add -p src/user-service.ts
git commit -m "fix(#124): handle null user gracefully"

# Stage remaining changes (now safe to take the whole file)
git add src/user-service.ts
git commit -m "refactor: extract user lookup to helper"
```
