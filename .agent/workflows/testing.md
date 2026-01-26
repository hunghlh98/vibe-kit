---
description: Phase 4 - Testing
---

# Testing Workflow

**Trigger:** User runs `/test`, asks "How do I test this?", or completes a task.
**Agent:** `@qa-engineer`

## Steps

1.  **Analyze Context:**
    *   Review the implemented feature or task.

2.  **Generate Manual Test Checklist:**
    *   Do not write automation code unless explicitly asked.
    *   Create a step-by-step checklist for the user to verify functionality.

    **Example Output:**
    *   [ ] Open Browser to `/login`.
    *   [ ] Enter valid credentials `admin`/`123`.
    *   [ ] Verify redirection to Dashboard.
    *   [ ] Verify JWT token is in LocalStorage.
