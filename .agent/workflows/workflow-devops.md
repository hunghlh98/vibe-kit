---
description: DevOps Workflow (Release & Deployment)
---

# DevOps Workflow

## 1. Prime Directive: Automation First
- **Tooling**: Prefer scripts over manual commands.
- **Tool**: Use `.agent/skills/brainstorming/SKILL.md` when designing complex automation scripts.
- **Scripts Location**: `./scripts/` (Injected by Vibe Kit).

## 2. Release Management
- **Command**: `./scripts/release.sh`
- **Process**:
    1. Checks for clean working directory.
    2. Bumps version in `package.json` or `pom.xml`.
    3. Auto-generates `CHANGELOG.md` from git history.
    4. Creates `vX.Y.Z` git tag.
    5. Pushes tag to origin.

## 3. Deployment
- **Command**: `./scripts/deploy.sh`
- **Prerequisites**: SSH interaction configured (keypair).
- **Process**:
    1. Builds the artifact (Jar or Dist).
    2. Rsyncs artifacts to Target Server.
    3. Reloads services (Docker Compose).
