---
description: Standardized Commit Workflow using Smart Commit script.
---

# Git Commit Workflow

## 1. Objective
To ensure every commit is semantic and incrementally versions the project.

## 2. Prerequisites
- `scripts/smart-commit.sh` must exist.
- A version source (`VERSION`, `package.json`, or `pom.xml`) must exist.

## 3. Workflow Steps
1.  **Stage Changes**: `git add <files>`
2.  **Execute Smart Commit**:
    ```bash
    ./scripts/smart-commit.sh -m "<type>(<scope>): <subject>"
    ```
    *Example*: `./scripts/smart-commit.sh -m "feat(auth): add login endpoint"`

## 4. Outcome
- Version is bumped (Patch level).
- Changes are committed with standard message.
