---
description: Backend Development Workflow (Java/Spring Boot)
---

# Backend Workflow

## 1. Planning Phase
- **Input**: `docs/PROJECT_PLAN.md` (derived from FRS/Stories).
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` to design domain models and API contracts before coding.
- **Action**: Create an entry in `docs/IMPLEMENTS.md` describing the technical task.
  - *Note*: `IMPLEMENTS.md` is an **APPEND-ONLY** log. 
  - **Instruction**: Always scroll to the bottom and add a new entry. **NEVER** overwrite or delete past entries.

## 2. Implementation Phase
- **Rule**: Follow "The Batching Rule" (See `skills/java/SKILL.md`).
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` if you encounter complex logic or need to decide between multiple implementation approaches.
- **Steps**:
  1. Define Entity & Repository.
  2. Implement Service logic.
  3. Create Controller & DTOs.
  4. Run Compilation (`./mvnw clean compile`).

## 3. Documentation Phase
- **Changelog**: Update `CHANGELOG.md` with:
  ```markdown
  ### [Unreleased]
  - Added [Feature Name] ([JIRA-123])
  ```
