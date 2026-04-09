---
name: Code review should check Jira ticket
description: When reviewing PRs, extract the Jira ticket ID from the PR/branch title and fetch ticket details for additional context
type: feedback
---

When reviewing a PR or branch, check for a Jira ticket ID (e.g., SMPROD-12345) in the PR title or branch name. If found, fetch the ticket for additional context about the change's purpose and requirements.

**Why:** The Jira ticket often contains acceptance criteria, design decisions, and constraints that aren't visible in the code diff alone. Reviewing without this context can miss intent mismatches.

**How to apply:** During Phase 0/1 of code review, extract the ticket ID and use the jira-tool skill to fetch details before analyzing the diff.
