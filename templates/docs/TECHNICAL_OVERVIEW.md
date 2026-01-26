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
