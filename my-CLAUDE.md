# Global Claude instructions

## Brainstorming Sessions

### Stay High-Level Until Implementation

  During brainstorming/design sessions, avoid code-level details (interfaces, method signatures, class structures). Focus on:

- Architecture decisions
- Component responsibilities
- Data flow
- Migration strategy

  Example:

- Good: "Auth client provides circuit breaker, retry, caching"
- Bad: `public interface AuthClient { AuthResult authenticate(HttpHeaders headers); ... }`

  Code details belong in implementation sessions, not design sessions.

### Keep Migration Plans Simple

  Don't over-engineer rollout strategies. If the team has existing mechanisms (like region-based deployment), use those instead of proposing new ones (percentage rollouts, shadow mode, contract tests).

  Example:

- Good: "Deploy to low-risk regions first, then roll out to others"
- Bad: "Phase 3a: Enable for 10% of customers, Phase 3b: Shadow mode comparison..."

### Prefer Complete Decoupling Over Optimization

  When designing service decoupling, prefer including all data in a single source even if some data rarely changes. Complete decoupling is more valuable than minor optimizations.

  Example:

- Good: "Include featureEnabled in bulk dump even though it never changes - one request gets everything"
- Bad: "Keep featureEnabled as a separate call since it can be cached forever"

### Cross-Instance Consistency in Distributed Systems

  When designing caching strategies for services with multiple instances, always consider:

- What happens when one instance has updated data and another doesn't?
- How will this affect user sessions that hit different instances?
- Is there existing infrastructure (Redis pub/sub, etc.) for cache coordination?

## Research Before Design Decisions

### Verify Assumptions About Data Dependencies

  Before deciding to exclude data from a cache or keep it as a live call, research how that data is actually used:

- Is it pass-through only (returned in response but not used for computation)?
- Is it on the hot path (used for every request)?
- Is it security-critical?

  Example:

- Good: "Let me spawn a researcher agent to check if customer settings are used for auth computation"
- Bad: "Customer settings seem like feature flags, let's keep them as live calls"

## Bug Fixing Process

  When fixing bugs, the user expects:

  1. **Write a failing test FIRST** that reproduces the bug
  2. **Only then** implement the fix
  3. Verify the test passes

  Example:

- Good: "Create a test verifying this behaviour and ONLY after fix it"
- Bad: Fix the bug first, then add tests afterward

## API Design Philosophy

### Prefer extending APIs over forcing caller conversions

When an API method requires type A but callers naturally have type B, add an overload accepting type B rather than requiring callers to convert. The API should accommodate its callers, not the reverse.

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if any.

## Tracer Bullets

When building features, build a tiny, end-to-end slice of the feature first, seek feedback, then expand out from there.

Tracer bullets comes from the Pragmatic Programmer. When building systems, you want to write code that gets you feedback as quickly as possible. Tracer bullets are small slices of functionality that go through all layers of the system, allowing you to test and validate your approach early. This helps in identifying potential issues and ensures that the overall architecture is sound before investing significant time in development.

## Code Comments

Comments explain what code alone cannot — the WHY, not the WHAT. These four categories carry the most value; use them generously when applicable, not sparingly.

### API/Interface comments

Document public function/class/module boundaries so callers can use them without reading the implementation.

- **Why**: Enables black-box reading and keeps the contract visible next to the code.
- **How to apply**: At exported functions and module entry points, describe inputs, outputs, side effects, and error modes. Skip for private helpers where clear naming is sufficient.

### Design rationale

At file-top or module-level, briefly justify the chosen approach vs. obvious alternatives.

- **Why**: Prevents well-meaning refactors from undoing intentional trade-offs.
- **How to apply**: When the file implements a non-trivial algorithm, protocol, or a design where an obvious alternative was rejected. 2–4 lines, not a dissertation.

### Teacher/domain comments

Explain specialist knowledge (math, protocols, domain invariants) inline so non-specialists can safely contribute.

- **Why**: Expands the set of people who can modify the code without damaging domain-correct logic.
- **How to apply**: Where code encodes a formula, protocol rule, or business invariant not obvious from names. One line or a link to a reference.

### Checklist/dependency comments

Warn when modifying X requires also touching Y elsewhere.

- **Why**: Prevents partial updates that break hidden invariants.
- **How to apply**: At sites with hidden coupling (e.g., "if you add an enum value here, also update Z"). One line, pointing at the other site.

### Anti-patterns

- **Restating what code does** — names carry that load; don't write `i++; // increment i`
- **Commenting-out code** — delete it; let VCS remember it
- **TODO/FIXME in source** — put them in design docs or issue trackers

## Code Quality

### Principle of Least Surprise

Match existing codebase patterns over personal preference; predictable code beats clever code.

- **Why**: Other developers voluntarily improve code they can predict; surprising code slows every future reader.
- **How to apply**: Before introducing a new idiom, library, or abstraction, check how the codebase solves similar problems and match that. Only deviate with a documented reason.

### Consistency

Follow the codebase's existing style, naming, and structure before introducing new patterns.

- **Why**: Consistency makes inconsistency meaningful — new patterns signal new intent; if everything is bespoke, nothing stands out.
- **How to apply**: Read a neighboring file before adding code; match its conventions (naming, error handling, layering). If the current patterns are actively wrong, propose a migration in a separate PR rather than fixing ad-hoc.

## Principle Trade-offs

When design principles conflict, apply these tiebreakers.

### Surprises override simplicity

Clever simple code loses to predictable verbose code.

- **Why**: The cost of surprise compounds — every reader pays it, indefinitely.
- **How to apply**: If a "simpler" solution requires readers to know a non-obvious trick (uncommon stdlib behavior, implicit control flow, operator overloading), prefer the longer predictable form.

### Wrong abstraction > duplication

Leave duplication in place rather than force a DRY extraction that doesn't quite fit.

- **Why**: Wrong abstractions spread, invite conditional flags, and resist change — costing more than duplication ever did.
- **How to apply**: If two pieces of code look similar but differ in intent, don't extract. Wait until at least three true duplicates with a genuinely stable shared shape emerge.

### Measure before optimizing

No performance work without profiling evidence.

- **Why**: Intuition about hot paths is usually wrong; unmeasured "optimizations" often harm readability without measurable benefit.
- **How to apply**: Produce a profile or benchmark showing the target is the bottleneck before changing code. Capture before/after numbers in the PR.

### Boy Scout time-gate

Clean up adjacent messy code only when the fix is quick; don't expand scope.

- **Why**: Unbounded cleanup bloats PRs, obscures the actual change, and creates review fatigue.
- **How to apply**: Fix an incidental issue only if it takes a minute and stays in-scope. Otherwise, open a follow-up. A bug fix PR shouldn't also contain renames, refactors, or unrelated reformatting.
