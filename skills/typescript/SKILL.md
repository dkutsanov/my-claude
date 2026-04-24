---
name: typescript
description: Use when writing, modifying, or reviewing TypeScript/JavaScript code — applies TypeScript-specific practices (strict typing, no any, Jest testing rules) on top of the clean-code rules in the global CLAUDE.md. TRIGGER when the user works with .ts/.tsx/.js/.jsx files, mentions TypeScript/JavaScript, Jest, Node, React, or any TS-related tooling.
---

# TypeScript Development

Write clean, maintainable TypeScript. Follow the shared "Clean Code" rules in the global CLAUDE.md (no JSDoc on private methods; pragmatic abstraction; constants only when reused; names over comments; comments explain WHY not WHAT). This skill carries the TypeScript-specific details that don't live in CLAUDE.md.

## TypeScript-Specific Practices

### Type safety

- Use strict TypeScript configuration
- Avoid `any` — use `unknown` and narrow with type guards
- Let type inference do the work where obvious; add explicit return types on public functions
- Export narrow, intentional types rather than re-exporting library internals

```typescript
// ✅ GOOD
function processValue(value: unknown): string {
  if (typeof value === 'string') return value.toUpperCase();
  if (typeof value === 'number') return value.toString();
  throw new Error('Unsupported type');
}

// ❌ BAD
function processValue(value: any): string {
  return value.toString();
}
```

### Post-implementation verification

After finishing any implementation (new code, modification, refactor), run the project's typecheck command (`yarn typecheck`, `pnpm typecheck`, `npx tsc --noEmit`, or whatever the repo uses) and fix type errors before considering the work complete.

## Jest Testing Rules

### Don't use `fail()`

`fail()` is a Jasmine global not recommended in Jest. Capture the error and assert outside `try/catch`, or use `expect().toThrow()`.

```typescript
// ❌ BAD
it('should throw error', () => {
  try {
    doSomething();
    fail('Expected an error');
  } catch (e) {
    expect(e.message).toBe('error');
  }
});

// ✅ GOOD — assert outside the try block
it('should throw error', () => {
  let thrownError: Error | null = null;
  try { doSomething(); } catch (e) { thrownError = e as Error; }
  expect(thrownError).not.toBeNull();
  expect(thrownError!.message).toBe('error');
});

// ✅ ALSO GOOD
it('should throw error', () => {
  expect(() => doSomething()).toThrow('error');
});
```

### Don't use conditional expects

Avoid `expect` inside `if` blocks or `catch` clauses. Narrow the value first, then assert unconditionally.

```typescript
// ❌ BAD
it('should have property', () => {
  const result = getResult();
  if (result) {
    expect(result.value).toBe(42);
  }
});

// ✅ GOOD
it('should have property', () => {
  const result = getResult();
  expect(result).toBeDefined();
  expect(result!.value).toBe(42);
});

// ❌ BAD — expect in catch
it('should have error location', () => {
  try { parse(input); }
  catch (e) { expect(e.location).toBeDefined(); }
});

// ✅ GOOD — capture and assert outside
it('should have error location', () => {
  let error: ParseError | null = null;
  try { parse(input); } catch (e) { error = e as ParseError; }
  expect(error).not.toBeNull();
  expect(error!.location).toBeDefined();
});
```

## TypeScript Code Review Checklist

- [ ] No `any` types (use `unknown` + type guards)
- [ ] Public function return types are explicit
- [ ] No JSDoc on private methods / implementation details
- [ ] Public JSDoc adds real value (not just restating the signature)
- [ ] No `fail()` in tests
- [ ] No conditional `expect` calls in tests
- [ ] `tsc --noEmit` passes cleanly
