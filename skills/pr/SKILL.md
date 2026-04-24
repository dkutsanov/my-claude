---
name: pr
description: Use when the user asks to create, open, or put up a pull request for the current branch. Handles branch push, PR creation via GitHub MCP, issue linking, assignee assignment, and label application. Do NOT use to review PRs, update descriptions on already-open PRs, or look up PR status — those are separate concerns.
allowed-tools: Bash(git status:*), Bash(git log:*), Bash(git push:*), Bash(git diff:*), Bash(git rev-parse:*), Bash(git branch:*), Bash(gh pr edit:*), Bash(gh pr view:*)
---

# Create Pull Request

Create a pull request for the current branch using GitHub MCP tools. Use `gh` CLI only for post-creation edits (assignee, labels) — creation itself goes through MCP.

## Output Style

- Never explicitly mention TDD in commits, PRs, or issues. The code speaks for itself; TDD is the process, not the product.

## Process

### 1. Ensure branch is ready

- Run `git status` to confirm working tree is clean (or all intended changes are staged/committed).
- Run `git log --oneline -5` to read recent commit messages — these inform both PR title and body.
- If commits exist locally that haven't been pushed, run `git push -u origin <branch-name>`.

### 2. Choose the PR title format

Check whether the target repo has a `CLAUDE.md` declaring a title convention (e.g. `sysdig-backend/CLAUDE.md` specifies `[JIRA-ID] Description`). **Project convention wins**.

- **If the repo specifies a convention**, use it verbatim. Extract the Jira ID from the branch name or the most recent commit message if needed.
- **Otherwise**, default to conventional commits: `feat(#123): add user authentication`, `fix(owner/repo#45): ...`, etc.

Keep the title short (under ~70 chars). Put detail in the body.

### 3. Write the PR body

Default template:

```markdown
## References

- <links to github issues or Jira tickets referenced in commit messages>

## Summary

<1-3 bullets describing what changed and why>

## Test Plan

- [ ] <specific verification steps>
- [ ] Tests pass
```

Populate `References` from any `#123`, `owner/repo#123`, or `JIRA-XXX` patterns found in commit messages or branch name.

### 4. Create the PR

Use the GitHub MCP tool to create the PR. Default base branch is `main` unless the user specifies otherwise or the repo's default differs.

### 5. Finalize the PR

After creation, always run:

```
gh pr edit <number> --add-assignee dkutsanov
```

Additionally, when the PR is in the `draios/backend` repo and the diff touches alerting domain code (files under `alerting/alert-manager/`, `alerting/alert-notifier/`, `alerting-api/`, or any other alerting-related module), also run:

```
gh pr edit <number> --add-label "alerts&events"
```

The team uses this label to track alerting-related changes.

### 6. Report the PR URL

Return the PR number and URL to the user so they can open it.
