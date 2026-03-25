---
description: Analyze conversation context for unaddressed items and gaps
argument-hint: [optional focus area]
---

# Gap Analysis

Analyze the current conversation context and identify things that have not yet been addressed.

**User arguments:**

Gap: $ARGUMENTS

**End of user arguments**

## What to Look For

1. **Incomplete implementations** — code started but not finished
2. **Unused variables/results** — values captured but never used
3. **Missing tests** — functionality without test coverage
4. **User requests** — things the user asked for that weren't fully completed
5. **TODO comments** — TODOs mentioned in conversation or code
6. **Error handling gaps** — missing error cases or edge cases
7. **Documentation gaps** — undocumented APIs or features
8. **Consistency issues** — inconsistent patterns, naming, or structure across the codebase

## Output

Present findings as a prioritized list with:

- What the gap is
- Why it matters
- Suggested next action

If there are no gaps, confirm that everything discussed has been addressed.
