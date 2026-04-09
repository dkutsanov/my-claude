---
name: PR creation checklist
description: When creating PRs, always assign to dkutsanov and add "alerts&events" label for alerting-related changes in the backend repo
type: feedback
---

Always assign PRs to the user when creating them.
**Why:** User expects to be the assignee on PRs they asked to create.
**How to apply:** After `gh pr create`, run `gh pr edit <number> --add-assignee dkutsanov`. GitHub username is `dkutsanov`.

Add the "alerts&events" label to PRs in the backend repo when changes touch alerting domain code.
**Why:** Team uses this label to track alerting-related changes.
**How to apply:** If the PR modifies files under `alert-manager/`, `alert-notifier/`, or any alerting domain class, run `gh pr edit <number> --add-label "alerts&events"`.
