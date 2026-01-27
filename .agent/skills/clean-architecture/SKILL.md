---
description: Clean Architecture standards and best practices.
---

# Clean Architecture Skill

## 1. Prime Directive: Dependency Rule
- **Rule**: Source code dependencies MUST point inward only.
- **Implication**: Inner concentric circles (Entities, Use Cases) know nothing of outer circles (UI, DB, Frameworks).
- **Control**: Use Polymorphism (Interfaces) to reverse flow of control.

## 2. Layers & Boundaries
- **Entities (Enterprise Logic)**: Pure business objects. No framework dependencies. Encapsulate high-level rules.
- **Use Cases (Application Logic)**: Orchestrate data flow to/from Entities. Define Input/Output Ports.
- **Interface Adapters**: Convert data from Use Case format to UI/DB format (Controllers, Presenters, Gateways).
- **Frameworks & Drivers**: The glue (Web, DB, Devices). Keep strictly isolated.

## 3. Critical Rules
- **Data Crossing**: Pass simple DTOs across boundaries. Never pass Entities to the UI.
- **Interface Ownership**: Interfaces belong to the client (Use Case), not the implementer (Gateway).
- **Humble Object**: Separate hard-to-test behaviors (GUI, DB) from logic.
- **Testing**: Business rules must be testable without UI, DB, or Server.
