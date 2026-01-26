---
description: Phase 3 - Backend Implementation
---

# Backend Implementation Workflow

**Trigger:** User runs `/code` (with backend context) or picks a Backend task from `IMPLEMENTS.md`.
**Agent:** `@backend-specialist`

## Steps

1.  **Preparation:**
    *   Read `docs/architecture/clean-arch-rules.md` (if available) to ensure compliance.
    *   Read the task details from `docs/IMPLEMENTS.md` or user prompt.

2.  **Generate Code (Batch Mode):**
    *   **Rule:** "1 Message = All JVM Operations."
    *   Generate all related files in a single turn:
        *   **Entity** (Domain Layer)
        *   **Repository** (Interface)
        *   **Service** (Application Layer)
        *   **Controller** (Infrastructure/API Layer)
        *   **DTOs** (Records)

3.  **Verification:**
    *   **Action:** // turbo
    *   Run `mvn test` to execute unit tests.
    *   Fix any compilation errors or test failures immediately.
