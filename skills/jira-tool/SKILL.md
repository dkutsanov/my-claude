---
name: jira-tool
description: Use when user provides Jira issue URLs or mentions Jira tickets - fetches issue details and comments from Jira Cloud using local jira tool, outputs AI-optimized markdown for context gathering
---

# Using the Jira Tool

**Core principle:** When users mention Jira issues or provide Jira URLs, immediately run `jira "<url-or-key>"`. Don't explore the tool's code, don't explain internals — just run it and use the output. If the `jira` command is not found, tell the user to install it and put it on the PATH (fall back to Atlassian MCP tools if available).

```bash
jira PROJ-123
jira "https://company.atlassian.net/browse/TICKET-123?filter=all"   # always quote URLs — query params break unquoted
jira PROJ-123 > context.md                                          # save for later use
```

The tool prints markdown to stdout (metadata, description, all comments); errors go to stderr, so stdout stays clean for piping.

## When to use

- User provides a Jira URL or issue key, asks for ticket context, or asks to implement from a ticket.
- Not for creating/updating issues (the tool is read-only), and not when a Jira URL is only a passing reference.

## Configuration errors

The tool reads `ATLASSIAN_EMAIL`, `ATLASSIAN_TOKEN`, `ATLASSIAN_DOMAIN` from `.env`. On credential/connection errors, point the user at the corresponding variable rather than debugging the tool.
