---
name: implement
description: Use when the user asks to implement a feature, add a class or method, fix a bug, refactor code, or add test coverage. The work is designed, implemented with tests, and verified. Do NOT use for code review, CI/CD setup, testing questions, infrastructure, or documentation tasks.
---

# Implement

Build the requested behavior together with the tests that verify it.

`$ARGUMENTS` is the work description. Empty → take the obvious next thing from the conversation, or `bd ready` if Beads is available.

## 1. Agree the scenarios

- Source them in order: explicit scenarios in the request → Given-When-Then acceptance criteria on the task → the design doc.
- With none available, write the list yourself — one line per behavior, happy path plus edge cases — and get it confirmed. Prose, not test code.
- Ambiguous edge cases are questions for the user.

## 2. Design before coding

- State the shape of the change — modules, boundaries, data flow — in a few lines before writing code.
- Match how the codebase already solves similar problems (see the global CLAUDE.md rules on least surprise and consistency).

## 3. Implement with tests

- Every agreed scenario ends up as a test; the writing order is yours to choose.
- Structure: Arrange (minimal setup) → Act (one action) → Assert (specific expectations).
- Expected values come from the scenario, hand computation, or a known-good fixture.
- A test that fails against an agreed scenario is a finding to report; changing that test needs the user's agreement.
- For DOM tests, select via `data-testid` and synchronize with `waitFor`/`findBy*`/events.
- Expensive setup (browser tests, Storybook stories): extend an existing interaction flow with more assertions; genuinely new interactions get their own test.

## 4. Verify

- Run the relevant suite and report the real output.
- **Strength check.** Where mutation testing is configured for the module, run it scoped to the changed classes and address the survivors. Otherwise break the behavior each new test targets, confirm the test fails, then revert the break.
- Run the project's coverage, lint, and static analysis, and act on what they report.

## 5. Clean up

- Improve structure in implementation **and** test code without changing behavior: types, renames, extractions, named constants.
- Targets: deep nesting, long functions, real duplication, single-implementation abstractions, dead code, magic values, patterns inconsistent with the surrounding codebase.
- Trigger from what the diff and the tools show — a static-analysis warning, a module that grew too big.
- When a pure structural change breaks a test, suspect the test asserts implementation details; fix the test.

## Shared rules

- The global CLAUDE.md rules apply throughout: Output Style (synthesis, plain words, essentials only) for the scenario list and progress reports, plus artifacts, comment discipline, and plan files.
- **Task tracking.** Use the harness task tools; if Beads is available, mirror through `bd` / `mcp__beads__*`.
- **Commit as you go.** Atomic, committable progress survives context limits.
