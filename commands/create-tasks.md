---
description: Break a feature or design into TaskCreate tasks with acceptance criteria and dependencies.
argument-hint: <feature description | GitHub issue URL/number | path to design doc>
---

# Create Tasks

Turn a feature, design doc, or GitHub issue into a dependency-ordered list of `TaskCreate` tasks.

**User arguments:**

$ARGUMENTS

**End of user arguments**

If the input is empty, use the current conversation context (typically a design doc produced by `/brainstorm`).

## Input handling

- **Feature description** — use it directly.
- **GitHub issue URL / number** — fetch it and extract problem, acceptance criteria, technical notes, dependencies.
- **Path to a design doc** — read it; treat the design as authoritative.

Discovery questions (problem, constraints, success criteria) belong in `/brainstorm`. This command assumes understanding is already there.

## For each task, call TaskCreate

- **subject** — imperative, specific. "Add JWT token validation middleware", not "Auth work".
- **activeForm** — present continuous for the spinner. "Adding JWT token validation".
- **description** — use this shape:

```markdown
## Context
Why this task exists and how it fits the larger feature.

## Technical Approach
- Key interfaces or types
- Algorithm / pattern
- Libraries to use

## Acceptance Criteria
- Given-When-Then bullets
- Cover happy path + edge cases
- Each bullet must be concretely verifiable
```

## Dependencies

After creation, call `TaskUpdate` on each task with:
- `addBlockedBy: [ids]` — tasks that must finish first
- `addBlocks: [ids]` — tasks this one blocks

Order tasks so the first one is a real starting point (no unresolved `blockedBy` links).

## Beads (optional)

If Beads MCP is available, mirror each task as a Beads issue:

```
bd create "title" --type [feature|bug|task|chore] --priority [1-3] \
  --description "context" --design "approach" --acceptance "Given-When-Then"
```

Use `bd dep add` to mirror the task dependencies.

## Self-check before finishing

- [ ] Each task has concrete Given-When-Then acceptance criteria
- [ ] Dependencies reflect real ordering (no cycles, first task is unblocked)
- [ ] Each task is small enough to finish in one TDD cycle

## Next command

- Run `/implement red <first task>` to start on the top unblocked task.
