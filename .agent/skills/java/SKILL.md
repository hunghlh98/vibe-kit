---
name: java-spring-boot-expert
description: Core backend skill for Java Spring Boot 3.5.8 development following Clean Architecture.
---

# Java Spring Boot Expert

## Source
Antigravity analysis.

## Guidelines

### Constraint Injection
*   **Batching Rule:** "Write Entity + Repository + Service + Controller + DTOs in ONE response."

### Technical Stack
*   **Java 21:** Use `var` for local variables, `record` for DTOs.
*   **Spring Boot 3.5.8:** Use `Jakarta` imports. Use `@RestControllerAdvice` for global error handling.
*   **Mapping:** Use `MapStruct` interface definitions (don't write manual mappers).
