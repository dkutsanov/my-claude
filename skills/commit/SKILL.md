---
name: commit
description: Create a git commit following project standards. Use when the user asks to commit, or after completing a task that produces code changes ready to commit. Do NOT use when the user only asks to review, diff, or check status without committing.
---

# Git Commit

Create a git commit following project standards.

## Commit Message Rules

Follows [Conventional Commits](https://www.conventionalcommits.org/) standard.

1. **Format**: `type(#issue): description`
   - Use `#123` for local repo issues
   - Use `owner/repo#123` for cross-repo issues
   - Common types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

2. **Content**: Write clear, concise commit messages describing what changed and why

3. **No AI attribution**: NEVER add `Co-Authored-By` trailer lines to commit messages (e.g. `Co-Authored-By: Claude <...>`). The user does not want AI attribution in git history. This rule applies whether you invoke this skill or fall back to a raw `git commit` command.

## Process

1. Run `git status` and `git diff` to review changes
2. Run `git log --oneline -5` to see recent commit style
3. Stage relevant files with `git add`
4. Create commit with descriptive message
5. Verify with `git status`

## Example

```bash
git add <files>
git commit -m "feat(#123): add validation to user input form"
```
