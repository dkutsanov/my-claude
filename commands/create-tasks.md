---
description: Create implementation plan from feature/requirement with PRD-style discovery and TDD acceptance criteria
argument-hint: <feature/requirement description or GitHub issue URL/number>
---

# Create Tasks: PRD-Informed Task Planning

Create structured implementation plan that bridges product thinking (PRD) with test-driven development.

**User arguments:**

Create-tasks: $ARGUMENTS

**End of user arguments**

(If no input provided, check conversation context)

## Discovery Phase

Understand the requirement by asking (use AskUserQuestion if needed):

**Problem Statement**

- What problem does this solve?
- Who experiences this problem?
- What's the current pain point?

**Desired Outcome**

- What should happen after this is built?
- How will users interact with it?
- What does success look like?

**Scope & Constraints**

- What's in scope vs. out of scope?
- Any technical constraints?
- Dependencies on other systems/features?

**Context Check**

- Search codebase for related features/modules
- Check for existing test files that might be relevant

## Input Processing

The input can be one of:

1. **Feature Description** (e.g., "Add user authentication")
2. **GitHub Issue URL/number** — extract problem statement, acceptance criteria, technical notes, and dependencies
3. **Empty** — use conversation context

## Create Tasks

For each task, use the TaskCreate tool with:

- **subject**: Action-oriented, specific title in imperative form (e.g., "Add JWT token validation middleware")
- **description**: Include context, technical approach, and acceptance criteria
- **activeForm**: Present continuous form for spinner display (e.g., "Adding JWT token validation")

**Task Description Structure:**

```
## Context
Why this task exists and how it fits into the larger feature.

## Technical Approach
- Key interfaces/types needed
- Algorithm or approach
- Libraries or patterns to use

## Acceptance Criteria
- Given-When-Then format
- Concrete, verifiable conditions
- Cover main case + edge cases
```

### Set Up Dependencies

After creating tasks, use TaskUpdate to establish ordering:

- **addBlockedBy**: Tasks that must complete before this one can start
- **addBlocks**: Tasks that cannot start until this one completes

### Beads Integration (Optional)

If Beads MCP is available, also create Beads issues:

```bash
bd create "Task title" \
  --type [feature|bug|task|chore] \
  --priority [1-3] \
  --description "Context" \
  --design "Technical approach" \
  --acceptance "Given-When-Then criteria"
```

Use `bd dep add` to track dependencies between Beads issues.

## Validation

After creating tasks, verify:

- Each task has clear acceptance criteria
- Dependencies are mapped correctly
- Tasks are ordered by implementation sequence
- Each task is small enough to implement incrementally

## Integration with Other Commands

- **Before**: Use `/spike` if you need technical exploration first
- **After**: Use `/implement red <first task>` to start on the first task
