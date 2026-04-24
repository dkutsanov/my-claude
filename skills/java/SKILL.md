---
name: java
description: Use when writing, modifying, or reviewing Java code. TRIGGER when the user works with .java files, mentions Java classes/packages (Spring Boot, JUnit, Maven, Gradle for Java projects), references Java patterns (DTOs, POJOs, Beans, Repositories, Services), fixes Java exceptions (NullPointerException, ClassCastException), refactors Java classes, reviews PRs touching src/main/java/, or writes/refactors Spock (Groovy) tests. Also trigger for Android code written in Java. DO NOT trigger for Kotlin, Scala, or non-Spock Groovy, and DO NOT trigger for infrastructure tasks (Kubernetes, CI/CD, Docker) even if they mention a Java service.
---

# Java Development

Write clean, maintainable Java code. SOLID principles, composition over inheritance, and the shared "Clean Code" rules in the global CLAUDE.md (no Javadoc on private methods; pragmatic abstraction; constants only when reused; names over comments; comments explain WHY not WHAT). This skill carries the Java-specific details that don't live in CLAUDE.md.

## Java-Specific Practices

### Composition over inheritance

```java
// ✅ GOOD
public class EmailNotifier {
    private final MessageFormatter formatter;
    private final EmailSender sender;

    public EmailNotifier(MessageFormatter formatter, EmailSender sender) {
        this.formatter = formatter;
        this.sender = sender;
    }

    public void notify(User user, String message) {
        sender.send(user.getEmail(), formatter.format(message));
    }
}
```

### Clean overloads for optional parameters

```java
// ✅ GOOD
public void process(Data data) {
    process(data, ProcessingOptions.DEFAULT);
}

public void process(Data data, ProcessingOptions options) {
    // implementation
}

// ❌ BAD — forcing clients to pass null
public void process(Data data, ProcessingOptions options) {
    if (options == null) options = ProcessingOptions.DEFAULT;
}
```

### Utility methods vs constants

```java
// ❌ BAD
private static String getDefaultFormat() { return "yyyy-MM-dd"; }

// ✅ GOOD
private static final String DEFAULT_FORMAT = "yyyy-MM-dd";
```

## Rationalization Table (Java-specific)

| Excuse | Reality |
|--------|---------|
| "This private method is complex so I should document it" | If it's complex, refactor it into smaller, clearer methods. Don't document complexity. |
| "This helps IDE tooltips" | IDE tooltips are for public APIs. Private methods are implementation details. |
| "Just brief Javadoc won't hurt" | Any Javadoc on private methods violates the CLAUDE.md rule. No exceptions. |
| "This algorithm needs explanation" | Add a Design rationale comment at the method/file top explaining the WHY — that's the "Design rationale" category in the CLAUDE.md comment rules. |
| "This getter has side effects so it needs docs" | If a getter has side effects, it shouldn't be named 'get'. Rename it. |

## Java Code Review Checklist

- [ ] No Javadoc on private methods or constructors
- [ ] Public method Javadoc adds real value (not obvious from name/signature)
- [ ] Classes have single, clear responsibilities
- [ ] Composition used instead of inheritance where appropriate
- [ ] No unnecessary abstractions or premature generalizations
- [ ] Constants only extracted when reused
- [ ] Optional parameters handled via overloads, not `null` sentinels
- [ ] Code is self-documenting; comments follow the four-category rule

---

## Spock Testing (for Java projects)

Write Spock tests using data-driven testing, proper block structure, and clear sentence-style names. Applies when writing or refactoring `*Spec.groovy` test files in a Java project.

### The Iron Rule: 3+ similar tests = `where:` block

Writing 3+ tests with the same structure and different inputs **must** become one parameterized test with a `where:` block. No exceptions — refactoring takes 2 minutes, maintaining 10 near-duplicates takes hours.

Red flags that mean "use `where:` NOW":
- "I'm writing my 3rd test with the same structure"
- "Just need to change the input value"
- "Copy-paste-modify is fastest"
- "I'll consolidate later"

### Before / After

```groovy
// ❌ BAD — four near-duplicate tests
def "should calculate 20% discount for premium"() { ... }
def "should calculate 10% discount for regular"() { ... }
def "should calculate 5% discount for new"() { ... }
def "should calculate no discount for guest"() { ... }

// ✅ GOOD — one parameterized test
def "should calculate #expectedDiscount discount for #customerType customer"() {
    expect:
    calculator.calculateDiscount(orderAmount, customerType) == expectedDiscount

    where:
    customerType         | orderAmount         | expectedDiscount
    CustomerType.PREMIUM | new BigDecimal(100) | new BigDecimal("20.00")
    CustomerType.REGULAR | new BigDecimal(100) | new BigDecimal("10.00")
    CustomerType.NEW     | new BigDecimal(100) | new BigDecimal("5.00")
    CustomerType.GUEST   | new BigDecimal(100) | BigDecimal.ZERO
}
```

Use `#variable` in the test-name string to show which parameter varies.

### Block Structure

| Block | Purpose | Example |
|-------|---------|---------|
| `given:` | Setup and stubs | `repository.findById(1) >> Optional.of(user)` |
| `when:` | Execute the action under test | `service.processOrder(orderId)` |
| `then:` | Assertions, mock verification | `1 * emailService.sendWelcome(user)` |
| `expect:` | Single-line assertion (no `when:`) | `calculator.add(2, 3) == 5` |
| `where:` | Data table for parameters | see above |

### Mock vs Stub placement

- **Stub** → returns fake data → goes in `given:` → use `>>`
  ```groovy
  given:
  repository.findById(1) >> Optional.of(user)
  ```
- **Mock** → verifies interaction happened → goes in `then:` → use `*`
  ```groovy
  then:
  1 * emailService.sendWelcome(user)
  ```

### Strategy

- **Integration tests** — happy path only with a representative example; minimal mocking, focus on external interfaces
- **Unit tests** — edge cases, errors, boundaries; use `where:` blocks; one behavior per test

### Common Spock mistakes

| Mistake | Fix |
|---------|-----|
| 3+ similar tests | Use `where:` block |
| Stub in `then:` block | Move to `given:` |
| Mock verification in `given:` | Move to `then:` |
| Test name like `testCalculate()` | Use a full sentence: `"should calculate discount for premium customer"` |
| Hardcoded timestamps | Use `LocalDateTime.of(2025, 1, 15, 10, 30)` or similar |
| Magic numbers | Named variables or data-table columns |
