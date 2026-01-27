---
description: Instructions for creating and maintaining project documentation (PRD, FRS, Plans).
---

# Documentation Skill

## 1. Prime Directive: The Single Source of Truth
- **Philosophy**: Documentation is NOT an afterthought. It is the **blueprint** and the **contract**.
- **Rule**: If the code contradicts the docs, the docs are wrong. Update the docs FIRST, then the code.

## 2. Document Hierarchy & Flow
1. **`PRD.md`**: The Vision. (Why, Who, What).
2. **`FRS.md`**: The Blueprint. (Data Models, APIs, Logic).
3. **`USER_STORIES.md`**: The Tasks. (User Stories, Acceptance Criteria).
4. **`PROJECT_PLAN.md`**: The Roadmap. (Phases, Sprints).
5. **`TEST_STRATEGY.md`**: The Validation. (Critical Paths).
6. **`IMPLEMENTS.md`**: The History. (Append-only Log).
7. **`CHANGELOG.md`**: The Release Notes.

## 3. Template Usage
- Templates are located in `.agent/skills/documentation/templates/`.
- **Initialization**: Copy the relevant template to `docs/` if it doesn't exist.
- **Filling**: Follow the embedded queries (`>`) in the template. Remove instructions after filling.

## 4. Maintenance Rules
- **FRS Update**: If you change an Entity or API, update `FRS.md` IMMEDIATELY.
- **Plan Update**: When a task is done, mark it [x] in `PROJECT_PLAN.md` and log entry in `IMPLEMENTS.md`.
- **Changelog**: Add entry to `CHANGELOG.md` upon feature completion.
