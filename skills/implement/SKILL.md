---
name: implement
description: Use when the user asks to implement a feature, add a class or method, fix a bug, refactor code, add test coverage, run autonomously to drive work forward, or explore an unfamiliar problem space with throwaway code. Supports explicit phase selection via the first argument (spike | red | green | refactor | forever) and infers the phase from conversation and test state when no phase is given. With no arguments at all, defaults to forever (autonomous loop). Do NOT use for code review, CI/CD setup, testing questions, infrastructure, or documentation tasks.
---

# Implement

Drive work through the test-first cycle: one failing test (red) → minimal code to pass it (green) → clean up on green (refactor), with an optional spike pre-phase and an autonomous `forever` driver. Apply the **Shared Rules** plus **exactly one** Phase section per invocation — each phase has its own strictness contract, and mixing them weakens all of them.

## Phase Dispatch

Read `$ARGUMENTS` (the user's input after the skill name).

1. **No arguments** → `PHASE = forever`.
2. **First token matches `{spike, red, green, refactor, forever}`** (case-insensitive) → that phase. The remainder is `CONTEXT` (exploration topic, test name, implementation description, refactoring goal, or loop seed).
3. **Otherwise infer** from the conversation and current test state:
   - Exploring unknowns ("I don't know how X works", "figure out the API") → `spike`
   - New behavior described, no relevant failing test → `red`
   - Exactly one relevant failing test → `green`
   - All green and the ask is cleanup / rename / extract → `refactor`
   - "continue", "keep going", "drive", "go" → `forever`
   - Unclear → `red` (safest default; starts a fresh cycle)

Before acting, state the phase in one short line — `Entering <PHASE> phase.` — so the user can correct it.

## Shared Rules (all phases)

- **The cycle is the contract.** Never introduce logic without a failing test demanding it; never refactor on red; each step addresses exactly one issue. Stubs that make imports and test infrastructure work are always fine — logic without a failing test is not.
- **The process stays invisible.** The global CLAUDE.md rules on never mentioning TDD, comment discipline, and plan-file restrictions apply to everything this skill produces.
- **Task tracking.** Use the harness task tools; if Beads is available, mirror through `bd` / `mcp__beads__*`.
- **No context given?** Take the obvious next thing from the conversation, or `bd ready` if Beads is available.

## Phase: SPIKE

An optional pre-phase for when uncertainty makes a meaningful failing test impossible to write — unknown API returns, unclear feasibility, undocumented behavior. If you can write the test, skip the spike and go to `red`.

- The deliverable is **understanding, captured in prose** — the code is disposable. Work in a scratch area so nothing leaks into the real implementation.
- State a time budget up front and stop when you've learned what you needed, not when the code looks good.
- Afterwards, discard the code and start from `red`, re-deriving the implementation under the cycle rather than pasting spike code in.

## Phase: RED

- Add exactly **one** failing test describing the desired behavior. Adding a single test is always allowed — no prior test output needed, and starting on a new feature is valid even if other work is in flight.
- It must fail for the **right reason**: a behavioral assertion, not a syntax or import error. If the failure is a missing import/constructor, add the minimal stub and re-run until the failure is behavioral.
- Structure: Arrange (minimal setup) → Act (one action) → Assert (specific expectations).
- For DOM tests, select via `data-testid`, not CSS classes or text. No `sleep()` or hard-coded timeouts — use `waitFor`/`findBy*`/event-based sync.
- Exception for expensive setup (browser tests, Storybook stories): extend an existing interaction flow with more assertions rather than duplicating the setup; genuinely new interactions still get a new test.

## Phase: GREEN

- Write the **minimal** code that makes the one failing test pass, matching the failure message one step at a time: "not defined" → empty stub; "not a function" → method stub; assertion failure → the minimal logic.
- No anticipatory features, no second test, no refactoring of untested code. Ugly-but-green is fine — that's what refactor is for.

## Phase: REFACTOR

- Precondition: relevant tests are green and were run recently. If not, switch to the phase that fixes them.
- Improve structure — implementation **and** test code — without adding behavior. Types, renames, extractions, and named constants are fine.
- Targets: deep nesting, long functions, real duplication, single-implementation abstractions, dead code, magic values, patterns inconsistent with the surrounding codebase.
- If a pure refactor breaks tests, suspect the tests: they may assert implementation details rather than behavior. Fix the test, don't contort the code.

## Phase: FOREVER

Run autonomously until interrupted or genuinely stuck.

1. **Find work**, in order: the `CONTEXT` seed → unfinished conversation threads → coverage gaps or incomplete implementations → `git status` → `bd ready` → whatever would most improve the codebase.
2. **Execute** through the cycle: announce the current sub-phase (red / green / refactor) before each code action and apply that phase's section. Make atomic, committable progress and commit as you go — the trail is what survives context limits.
3. **Continue or pivot**: more related work → continue; blocked → note the blocker and switch tasks; repeated failures → try a different approach or a different task.

Stop only when the user interrupts, no work can be identified, or a decision genuinely needs human judgment. Work quietly: report completions, surface decisions that need input, skip the play-by-play.
