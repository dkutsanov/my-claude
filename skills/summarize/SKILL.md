---
name: summarize
description: Summarize conversation progress and next steps. Use when the user asks for a summary, wants to transfer context to a new conversation, or asks what was done so far. Do NOT use when the user asks to summarize a file, document, or external content.
---

# Summarize

Create a concise summary of the current conversation suitable for transferring context to a new conversation.

## Summary Structure

### What We Did

- Key accomplishments and changes made
- Important decisions or discoveries
- Files created, modified, or analyzed

### What We're Doing Next

- Immediate next steps
- Pending tasks or work in progress
- Goals or objectives to continue

### Blockers & User Input Needed

- Any issues requiring user intervention
- Decisions that need to be made
- Missing information or clarifications needed

## Output Format

Keep the summary concise and actionable - suitable for pasting into a new conversation to quickly restore context without needing the full conversation history.

Follow the global CLAUDE.md Output Style rules: carry the decisions and their reasons, in plain words, and leave the path that led to them behind.
