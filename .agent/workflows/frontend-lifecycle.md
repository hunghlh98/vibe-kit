---
description: Phase 3 - Frontend Implementation
---

# Frontend Implementation Workflow

**Trigger:** User runs `/code` (with frontend context) or picks a Frontend task from `IMPLEMENTS.md`.
**Agent:** `@frontend-specialist`

## Steps

1.  **Preparation:**
    *   Read UI Design System settings (Tailwind config, etc.).
    *   Read the task details.

2.  **Generate Code:**
    *   **Components:** Create functional React components using Shadcn/UI patterns.
    *   **Hooks:** Implement custom hooks for logic and state (Zustand/TanStack Query).
    *   **Styles:** Apply Tailwind CSS v4 classes.

3.  **Verification:**
    *   **Action:** // turbo
    *   Run `npm run build` to ensure no build errors.
    *   (Optional) Run tests if available.
