# 📦 TOOLKIT SPECIFICATION: Vibe-Kit (Java/React Edition)

**Purpose:** A portable Agentic Toolkit for rapidly scaffolding and managing dual-stack projects (Java Spring Boot Backend + React Vite Frontend).
**Core Philosophy:** Documentation-Driven Development (Agents read/write to `docs/`) + Specialized Personas.

## 1. Vibe-Kit Repository Structure

The toolkit itself acts as a "seed" repository. When you run `vibe-kit init`, it plants these files into your target project.

```text
vibe-kit/
├── .agent/
│   ├── skills/
│   │   ├── java/                # java-spring-boot-expert, clean-arch-check
│   │   ├── frontend/            # react-vite-expert, ui-ux-pro-max-lite
│   │   └── core/                # software-principles (SOLID/KISS/DRY)
│   ├── workflows/
│   │   ├── setup-project.md     # Master setup workflow
│   │   ├── backend-lifecycle.md # Batch coding & testing cycle
│   │   └── frontend-lifecycle.md# UI Component generation cycle
│   └── agents.yaml              # Source for AGENTS.md generation
├── templates/                   # DEFAULT PROJECT SCAFFOLDING (Crucial)
│   ├── AGENTS.md                # The Roster (as you defined)
│   ├── docs/
│   │   ├── TECHNICAL_OVERVIEW.md
│   │   ├── PRD.md
│   │   ├── PROJECT_PLAN.md
│   │   └── IMPLEMENTS.md
├── bin/                         # CLI scripts (e.g., vibe-init.sh)
└── README.md

```

---

## 2. Default Templates (The "Brain" Seeds)

These files are copied to every new project to give agents immediate context.

### 📄 `templates/AGENTS.md`

*Strictly uses your defined roster.*

```markdown
# 🤖 Antigravity Agents Roster

This project utilizes a team of specialized AI agents. When a task is assigned, the system (or user) selects the appropriate agent persona.

## 1. @Backend-Architect (Java Specialist)
* **Role:** Senior Java Engineer & Architect.
* **Capabilities:** Spring Boot 3.5.8, Java 21, Clean Architecture, Hibernate/JPA.
* **Prime Directive (The Batching Rule):** "1 Message = All JVM Operations." You must write ALL related files (Entity, Repo, Service, Controller) in a single turn before requesting a compilation/test run to avoid JVM startup latency.
* **Constraints:** STRICTLY forbids field injection (`@Autowired`). Enforces `record` types for DTOs.

## 2. @Frontend-Designer (React Specialist)
* **Role:** UI/UX Engineer & React Developer.
* **Capabilities:** React 18, Vite, Tailwind CSS v4, Shadcn/UI, Zustand/TanStack Query.
* **Source Skill:** `ui-ux-pro-max-lite` (Streamlined for React).
* **Constraints:** Uses Functional Components only. Validates against accessibility (WCAG) standards.

## 3. @Requirements-Analyst (Product Owner)
* **Role:** Translates raw ideas into structured Work Items.
* **Capabilities:** PRD analysis, User Story writing, Acceptance Criteria definition.
* **Workflow:** Reads `docs/PRD.md` -> Updates `docs/PROJECT_PLAN.md` -> Creates entries in `docs/IMPLEMENTS.md`.

## 4. @DevOps-Engineer
* **Role:** Infrastructure & CI/CD Manager.
* **Capabilities:** Docker, GitHub Actions, Maven Build Lifecycle.

```

### 📄 `templates/docs/TECHNICAL_OVERVIEW.md`

```markdown
# 🏗 Technical Overview

## 1. Architecture
* **Backend:** Hexagonal (Clean) Architecture.
    * `Domain` (Core Logic) -> `Application` (Use Cases) -> `Infrastructure` (Spring/DB).
* **Frontend:** Feature-Sliced Design (FSD) or Modular Monolith.

## 2. Principles
* **SOLID:** Single Responsibility is paramount for Agent code generation.
* **KISS:** Keep It Simple, Stupid. No over-engineering.
* **DRY:** Don't Repeat Yourself. Extract shared logic to utilities.
* **YAGNI:** You Ain't Gonna Need It. Do not generate speculative code.

```

### 📄 `templates/docs/IMPLEMENTS.md`

*The "Jira" for Agents.*

```markdown
# 🔨 Implementation Log

## To Do
* [ ] **TASK-INIT:** Setup project scaffolding using Vibe-Kit.

## In Progress
* (None)

## Done
* (None)

```

---

## 3. Skill Definitions (The "Knowledge")

### A. Backend Skills (`.agent/skills/java/`)

**1. `java-spring-boot-expert` (Core Skill)**

* 
**Source:**  (Antigravity analysis).


* **Constraint Injection:**
* **Batching Rule:** "Write Entity + Repository + Service + Controller + DTOs in ONE response."
* **Java 21:** Use `var` for local variables, `record` for DTOs.
* **Spring Boot 3:** Use `Jakarta` imports. Use `@RestControllerAdvice` for global error handling.
* **Mapping:** Use `MapStruct` interface definitions (don't write manual mappers).



**2. `clean-architecture-check` (Linter Skill)**

* **Trigger:** File changes in `domain` or `application` packages.
* **Rule:** "Domain entities MUST NOT import `org.springframework.*` or `jakarta.persistence.*`."
* **Action:** If violation detected, stop and request refactor.

### B. Frontend Skills (`.agent/skills/frontend/`)

**1. `react-vite-expert**`

* **Rule:** Use `import.meta.env` (not `process.env`).
* **State:** `Zustand` for client state, `TanStack Query` for server state.
* **Performance:** Memoize expensive calculations only.

**2. `ui-ux-pro-max-lite**`

* 
**Source:**  (Adapted from `ui-ux-pro-max`).


* **Streamline:** Hardcode stack to `React` + `Tailwind` + `Lucide React`. Remove Vue/Angular logic.
* **Output:** Generates fully responsive, dark-mode ready components.

### C. Core Skills (`.agent/skills/core/`)

**1. `software-principles**`

* **Description:** A "Superego" skill that reviews code against SOLID, KISS, DRY, YAGNI.
* **Trigger:** Before any file write operation.
* **Check:** "Is this function doing too much?" (SRP), "Is this logic duplicated?" (DRY).

---

## 4. Setup Workflow (How it works)

When you run the toolkit initialization:

1. **Ask User:** "Backend (Java) or Frontend (React)?"
2. **If Backend:**
* Run `curl start.spring.io...` to get Java 21/Spring 3 zip.
* Unzip.
* **Inject:** Copy `templates/AGENTS.md` and `templates/docs/*` into root.
* **Inject:** Copy `.agent/skills/java` and `.agent/skills/core`.


3. **If Frontend:**
* Run `npm create vite@latest`.
* **Inject:** Copy `templates/AGENTS.md` and `templates/docs/*` into root.
* **Inject:** Copy `.agent/skills/frontend` and `.agent/skills/core`.



---