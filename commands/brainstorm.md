---
description: "Collaborative design session before implementation — refine the idea, explore 2-3 approaches, write a validated design doc to docs/plans/."
argument-hint: "The feature/idea to brainstorm"
---

# Brainstorm

Turn an idea into a validated design through dialogue, then capture the result in a dated design doc.

The idea for this session:
$ARGUMENTS

## How to run this

- Start by reading the current project state (recent commits, related files, docs).
- Ask one question at a time — prefer multiple choice over open-ended when both work. Break compound questions apart.
- After 2-3 questions, propose 2-3 distinct approaches with trade-offs. Lead with your recommendation and the reason.
- Once the shape is clear, present the design in 200-300-word sections (architecture, components, data flow, error handling, testing). Check alignment after each section.
- Stay high-level until implementation — see the global CLAUDE.md "Brainstorming Sessions" section for what counts as too-low-level.
- Dialogue and design doc both follow the global CLAUDE.md Output Style rules: conclusions over the material behind them, plain words, essentials only.

## When done

Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md` (create the directory if needed). Commit it as its own commit.

After that, `/create-tasks` takes the design and breaks it into implementable tasks.
