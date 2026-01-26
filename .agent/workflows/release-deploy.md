---
description: Phase 5 - Release & Deploy
---

# Release & Deploy Workflow

**Trigger:** User runs `/deploy` or says "Ship it".
**Agent:** `@release-manager`

## Steps

1.  **Backend Flow:**
    *   **Commit:** Generate conventional commit message (e.g., `feat(auth): implement jwt backend`).
    *   **Build:**
        *   // turbo
        *   Run `mvn clean package -DskipTests` (fast build).
    *   **Dockerize:** Build Dockerfile for Java 21 JAR.
    *   **Deploy:** Push to registry or restart local container.

2.  **Frontend Flow:**
    *   **Commit:** Generate conventional commit message (e.g., `feat(ui): add login page`).
    *   **Build:**
        *   // turbo
        *   Run `npm run build`.
    *   **Deploy:** Upload `dist/` folder to target (S3/Nginx/Docker).
