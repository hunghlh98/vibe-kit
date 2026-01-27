# Functional Requirements Specification (FRS)

> **Generated from PRD by Backend Architect.**

## 1. System Overview
> **High-level architecture summary.**

## 2. Data Models (Entities)
> **Define core domain entities/records.**
- `User` { id, email, role }
- `Order` { id, userId, status, total }

## 3. API Endpoints
> **Define key REST/GraphQL endpoints.**
- `POST /api/v1/resource` -> Create resource
- `GET /api/v1/resource/{id}` -> Get resource details

## 4. Business Logic / Algorithms
> **Describe complex logic, validation rules, or state machines.**

## 5. Non-Functional Requirements
- Performance:
- Security:
