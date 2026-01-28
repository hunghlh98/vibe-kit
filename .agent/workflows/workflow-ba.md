---
description: Business Analyst Workflow (Requirements Engineering)
---

# BA Workflow

## 1. Analysis Phase
- **Input**: Raw `PRD` or Feature Request.
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` to refine vague ideas into concrete requirements.
- **Output 1**: `docs/FRS.md` (Functional Requirement Specification).
  - Detailed system behavior, data models, and API contracts.

## 2. Elaboration Phase
- **Input**: `FRS.md`.
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` to brainstorm user journeys and edge cases.
- **Output 2**: `docs/USER_STORIES.md`.
  - Format: "As a [Role], I want [Feature], So that [Benefit]."
  - Acceptance Criteria: Gherkin syntax (Given/When/Then).

## 3. Execution Prep
- **Action**: Convert Stories into Actionable Tasks.
- **Output 3**: Update `docs/PROJECT_PLAN.md` with prioritized list.
