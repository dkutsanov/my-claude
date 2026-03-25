---
name: simplify
description: Review changed code for reuse, quality, and efficiency, then fix any issues found. Use when the user asks to simplify code, reduce complexity, clean up, or make code more readable. Do NOT use for adding features, fixing bugs, or structural refactoring.
---

# Simplify

Reduce complexity while keeping tests green.

## Core Principles

**YAGNI** - Don't build until actually needed. Delete "just in case" code.

**KISS** - Simplest solution that works. Clever is the enemy of clear.

**Rule of Three** - Don't abstract until 3rd occurrence. "Prefer duplication over wrong abstraction" (Sandi Metz).

## When NOT to Simplify

- Essential domain complexity (regulations, business rules)
- Performance-critical optimized code
- Concurrency/thread-safety requirements
- Security-sensitive explicit checks

## Prerequisites

Tests must be green. If failing, fix them first.

## Code Complexity Signals

Look for these refactoring opportunities:

- [ ] Nesting > 3 levels deep
- [ ] Functions > 20 lines
- [ ] Duplicate code blocks
- [ ] Abstractions with single implementation
- [ ] "Just in case" parameters or config
- [ ] Magic values without names
- [ ] Dead/unused code

## Techniques

| Pattern | Before | After |
|---------|--------|-------|
| Guard clause | Nested `if/else` | Early `return` |
| Named condition | Complex boolean | `const isValid = ...` |
| Extract constant | `if (x > 3)` | `if (x > MAX_RETRIES)` |
| Flatten callback | `.then().then()` | `async/await` |

**Also apply:** Consolidate duplicates, inline unnecessary abstractions, delete dead code.

## Validate

1. Tests still green
2. Code reads more clearly
3. No behavioral changes

**Simplify** removes complexity locally. **Refactor** improves architecture broadly.

### Watch for Brittle Tests

When refactoring implementation, watch for **Peeping Tom** tests that:

- Test private methods or internal state directly
- Assert on implementation details rather than behavior
- Break on any refactoring even when behavior is preserved

If tests fail after a pure refactoring (no behavior change), consider whether the tests are testing implementation rather than behavior.
