---
name: typescript-development
description: Use when writing, modifying, or reviewing TypeScript/JavaScript code - applies clean code practices, proper typing, and pragmatic patterns to create maintainable applications
---

# TypeScript Development

## Overview

Write clean, maintainable TypeScript code with proper typing and pragmatic practices. On public APIs, document inputs/outputs/side effects/errors; elsewhere, comment the WHY when non-obvious (see global `Code Comments` rules). Use strict TypeScript settings.

## Core Principles

### Type Safety
- Use strict TypeScript configuration
- Avoid `any` - use `unknown` and type guards instead
- Leverage type inference where types are obvious
- Define explicit return types for public functions

### Pragmatic Abstraction
- Only introduce abstractions when they provide clear value
- Avoid premature generalization
- **Don't create interfaces unless multiple implementations exist or type contracts are needed**
- Keep it simple until complexity is justified

## Clean Code Practices

### Documentation Rules

**Avoid JSDoc on private methods or implementation details**

Private methods are implementation details. If they need documentation, refactor for clarity instead.

**JSDoc on public APIs** — document boundaries so callers can use them without reading the implementation. Describe:
- Inputs, outputs, side effects
- Error modes and exceptions thrown
- Important constraints or assumptions

**Skip JSDoc on trivial getters/setters** — identifier names already carry the meaning:
```typescript
// ❌ BAD
/**
 * Gets the customer count
 */
public getCustomerCount(): number { return this.customers.length; }

// ✅ GOOD - self-documenting, no comment needed
public getCustomerCount(): number { return this.customers.length; }
```

### Constants and Magic Values
- **Only extract constants if used in multiple places**
- Don't create constants for single-use values - inline them with clear context
- Use meaningful names that explain purpose, not just value

### Naming and Clarity
- Prefer clear, descriptive names over comments
- Variables and methods should be self-documenting
- Avoid cryptic abbreviations
- Write code that reads like prose

### Comments
Comments explain what code alone cannot — the WHY, not the WHAT. Write them in these four high-value categories (see global `Code Comments` rules):
- **API/Interface**: inputs, outputs, side effects, error modes on public methods
- **Design rationale**: why this approach was chosen over alternatives
- **Teacher/domain**: formulas, protocol rules, business invariants
- **Dependency warnings**: when modifying X requires also touching Y

**Don't restate what code obviously does** — names carry that load. Never leave commented-out code or TODO/FIXME in source; delete code (VCS remembers) and move TODOs to design docs or issue trackers.

## Jest Testing Rules

### Don't Use `fail()` (jest/no-jasmine-globals)

The `fail()` function is a Jasmine global that's not recommended in Jest.

```typescript
// ❌ BAD - using fail()
it('should throw error', () => {
  try {
    doSomething();
    fail('Expected an error to be thrown');
  } catch (e) {
    expect(e.message).toBe('error');
  }
});

// ✅ GOOD - capture error and assert outside try/catch
it('should throw error', () => {
  let thrownError: Error | null = null;
  try {
    doSomething();
  } catch (e) {
    thrownError = e as Error;
  }
  expect(thrownError).not.toBeNull();
  expect(thrownError!.message).toBe('error');
});

// ✅ ALSO GOOD - use expect().toThrow()
it('should throw error', () => {
  expect(() => doSomething()).toThrow('error');
});
```

### Don't Use Conditional Expects (jest/no-conditional-expect)

Avoid calling `expect` inside `if` blocks or `catch` clauses.

```typescript
// ❌ BAD - conditional expect
it('should have property', () => {
  const result = getResult();
  if (result) {
    expect(result.value).toBe(42);
  }
});

// ✅ GOOD - use non-null assertion after existence check
it('should have property', () => {
  const result = getResult();
  expect(result).toBeDefined();
  expect(result!.value).toBe(42);
});

// ❌ BAD - expect in catch block
it('should have error location', () => {
  try {
    parse(input);
  } catch (e) {
    expect(e.location).toBeDefined(); // Conditional!
  }
});

// ✅ GOOD - capture and assert outside
it('should have error location', () => {
  let error: ParseError | null = null;
  try {
    parse(input);
  } catch (e) {
    error = e as ParseError;
  }
  expect(error).not.toBeNull();
  expect(error!.location).toBeDefined();
});
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Using `any` type | Use `unknown` with type guards |
| JSDoc on private methods | Remove it. Refactor for clarity. |
| Documenting obvious getters/setters | Remove JSDoc. Code is self-documenting. |
| Using `fail()` in tests | Capture error and assert outside try/catch |
| `expect` inside `if`/`catch` | Move expects outside conditional blocks |
| Creating interfaces prematurely | Wait until multiple implementations exist |

## Post-Implementation Verification

After finishing any implementation work (new code, modifications, or refactoring), always run a TypeScript compilation check to catch type errors early. Use the project's typecheck command (e.g., `yarn typecheck`, `npx tsc --noEmit`, or the equivalent configured in the project). Fix any type errors before considering the work complete.

## Code Review Checklist

Before finalizing TypeScript code:
- [ ] No `any` types (use `unknown` with type guards)
- [ ] Public function JSDoc adds real value (not obvious)
- [ ] No JSDoc on private methods/implementation details
- [ ] No `fail()` usage in tests
- [ ] No conditional `expect` calls in tests
- [ ] Code is self-documenting with clear names
- [ ] Comments are minimal and add real value
- [ ] TypeScript compilation passes with no errors

## Examples

### Type Guards Instead of Any
```typescript
// ✅ GOOD
function processValue(value: unknown): string {
  if (typeof value === 'string') {
    return value.toUpperCase();
  }
  if (typeof value === 'number') {
    return value.toString();
  }
  throw new Error('Unsupported type');
}

// ❌ BAD
function processValue(value: any): string {
  return value.toString();
}
```

### Self-Documenting Code
```typescript
// ✅ GOOD - clear without comments
function isEligibleForDiscount(customer: Customer): boolean {
  const hasEnoughOrders = customer.orderCount >= 10;
  const isLongTermCustomer = customer.accountAge > ONE_YEAR;
  return hasEnoughOrders && isLongTermCustomer;
}

// ❌ BAD - needs comment to explain
function check(c: Customer): boolean {
  // Check if customer has 10 orders and account older than 1 year
  return c.orderCount >= 10 && c.accountAge > 365;
}
```
