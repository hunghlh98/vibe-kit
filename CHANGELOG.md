# Changelog

All notable changes to **Antigravity Vibe Kit** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-01-27
### Added
- Single-line `curl` executor in `README.md` for instant onboarding.
- Smart version display in `bin/vibe-init.sh` (fetches assets before showing version).

## [1.0.3] - 2026-01-27
### Changed
- Decoupled version bumping from `smart-commit.sh` distributed to target projects.
- `smart-commit.sh` now strictly handles commit execution, while `release.sh` handles versioning.

## [1.0.2] - 2026-01-27
### Added
- **Self-Versioning**: Implemented `VERSION` file and `bin/smart-commit` for the toolkit itself.
- **Skills**:
  - `git-commit`: Conventional Commits standard + `smart-commit.sh`.
  - `clean-architecture`: Strict boundary enforcement rules.
  - `documentation`: "Single Source of Truth" templates (`PRD`, `FRS`, etc.).
- **Workflows**:
  - `workflow-git-commit`: Semantic commit loop.
  - `workflow-devops`: Release & Deployment pipeline.
- **Infrastructure**:
  - Enhanced `bin/vibe-init.sh` with remote asset fetching and smart updates.

## [1.0.0] - 2026-01-20
### Added
- Initial release of Vibe Kit.
- Basic scaffolding for Java Spring Boot and React Vite.
