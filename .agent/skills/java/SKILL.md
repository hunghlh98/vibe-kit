---
description: Specialized instructions for Backend Architects (Java/Spring Boot).
---

# Java Spring Boot Skill (Pro Max)

## 1. Prime Directive: The Batching Rule
- **Constraint**: "1 Message = All JVM Operations".
- **Why**: JVM startup is slow. Context switching is expensive.
- **Action**: Write `Entity`, `Repository`, `Service`, `Controller`, and `DTOs` in a SINGLE turn.

## 2. Core Java Pro
- **Modern**: Java 21+ (`records`, `var`, `switch`, `text blocks`, `virtual threads`).
- **OOP/Solid**: Clean Architecture.
- **Collections**: Expert usage (Streams, Optionals, Generics).
- **Modules**: JPMS understanding (`module-info.java`).

## 3. Spring Boot Ecosystem
- **Container**: IoC, Constructor Injection (NO `@Autowired` fields).
- **Web**: `@RestController`, `@ControllerAdvice`, OpenFeign (Sync).
- **Data**: JPA (`@Entity`, `@Table`), QueryDSL/Criteria, Avoid N+1 (`JOIN FETCH`).
- **Security**: OAuth2, OIDC, JWT, `@PreAuthorize`.
- **Config**: Externalized (`@ConfigurationProperties`), Profiles.

## 4. Concurrency & Performance
- **Threading**: `Project Loom` (Virtual Threads) for IO-bound.
- **Async**: `CompletableFuture`, `Spring Events`.
- **Tuning**: GC Tuning (G1/ZGC), Heap Analysis (VisualVM), Leak Detection.
- **Resilience**: Resilience4j (Circuit Breaker, Rate Limiter, Retry).

## 5. Microservices & Distributed Design
- **Comms**: Kafka/RabbitMQ (Event-Driven), REST/gRPC.
- **Patterns**: API Gateway, CQRS, SAGA, Service Discovery.
- **Observability**: OpenTelemetry, Zipkin, Prometheus, ELK.
- **Deploy**: Docker, Kubernetes (Helm), GitOps.

## 6. Build & Quality
- **Maven**: Multi-module standard. Dependency scopes.
- **Testing**: `MockMvc` (Web), `@DataJpaTest` (DB), TestContainers (Integration).
- **Review**: SOLID, KISS, DRY, YAGNI.
