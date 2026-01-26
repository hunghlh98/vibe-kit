---
description: Phase 1 - Setup Project Scaffolding
---

# Setup Project Workflow

**Trigger:** User runs `/setup` or asks to initialize a project.

## Steps

1.  **Identify Stack:**
    *   Ask the user: "Backend, Frontend, or Full Stack?"

2.  **Backend Path (Java Spring Boot):**
    *   **Input:** Ask for GroupID (e.g., `com.example`) and ArtifactID (e.g., `my-app`).
    *   **Action:** Execute `vibe-init.sh` option 1.
        *   Generates a Java 21 / Spring Boot 3.5.8 project.
        *   Injects Backend Skills and Clean Architecture rules.

3.  **Frontend Path (React Vite):**
    *   **Input:** Ask for Project Name.
    *   **Action:** Execute `vibe-init.sh` option 2.
        *   Generates a React 18 + Vite project.
        *   Installs Tailwind CSS v4.
        *   Injects Frontend Skills.

4.  **Full Stack Path (Both):**
    *   **Input:** Ask for GroupID (for backend).
    *   **Action:** Execute `vibe-init.sh` option 3.
        *   Creates a `backend/` folder (Java Spring Boot).
        *   Creates a `frontend/` folder (React Vite).
        *   Injects appropriate skills into each sub-directory.
