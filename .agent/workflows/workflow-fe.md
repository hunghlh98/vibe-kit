---
description: Frontend Development Workflow (React/Vite)
---

# Frontend Workflow

## 1. Planning Phase
- **Input**: `docs/PROJECT_PLAN.md` or Figma strings.
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` to plan component hierarchy and state management.
- **Action**: Identify Components and State requirements.

## 2. Implementation Phase
- **Rule**: "Visual Excellence" (See `skills/react-vite/SKILL.md`).
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` to explore design variations or complex interactions.
- **Steps**:
  1. Create UI Components (`components/ui`).
  2. Implement Feature Components (`components/features`).
  3. Wire up State & API.
  4. Verify Responsiveness.

## 3. Documentation Phase
- **Changelog**: Update `CHANGELOG.md` with:
  ```markdown
  ### [Unreleased]
  - Added [UI Component/Feature]
  ```
