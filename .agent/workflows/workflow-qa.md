---
description: Quality Assurance Workflow (Validation)
---

# QA Workflow

## 1. Test Planning
- **Input**: `docs/FRS.md` and `docs/USER_STORIES.md`.
- **Action**: Create `docs/TEST_PLAN.md`.
  - Define Test Cases (Happy Path, Edge Cases, Error States).

## 2. Automation
- **Tool**: Playwright (E2E) or JUnit (Integration).
- **Execution**: Run tests against Staging/Local env.

## 3. Validation
- **Action**: Manual Verification of UI/UX.
- **Report**: Log defects in `docs/DEFECTS.md` (if exists) or notify developer.
