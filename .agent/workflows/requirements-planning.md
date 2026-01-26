---
description: Phase 2 - Requirements & Planning
---

# Requirements & Planning Workflow

**Trigger:** User runs `/plan` or provides a raw requirement (e.g., "Add a login screen").
**Agent:** `@requirements-analyst`

## Steps

1.  **Analyze Request:**
    *   Review `docs/PRD.md` and the user's raw requirement.
    *   Identify the scope and impact.

2.  **Split Strategy:**
    *   **Backend Task:** Define necessary API changes (e.g., Create Auth API, JWT setup, UserEntity).
    *   **Frontend Task:** Define necessary UI changes (e.g., Create Login Form, React Hook Form, Axios integration).

3.  **Documentation Update:**
    *   **Update:** Append details to `docs/PROJECT_PLAN.md`.
    *   **Create Tickets:** Create specific, actionable entries in `docs/IMPLEMENTS.md`.
        *   Format: `* [ ] **[BE/FE]** Task Description`
