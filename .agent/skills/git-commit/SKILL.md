---
description: Semantic Git Commit standards (Conventional Commits).
---

# Git Commit Skill

## 1. Prime Directive: Semantic History
- **Rule**: Every commit MUST follow the Conventional Commits specification.
- **Why**: Allows automated changelog generation and clear history traversal.

## 2. Format
```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## 3. Commit Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to our CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

## 4. Best Practices
- **Atomic**: One logical change per commit.
- **Tense**: Use imperative, present tense ("change" not "changed" or "changes").
- **Breaking**: Append `!` after type/scope (e.g., `feat!: drop support for Node 6`).
- **Footer**: Reference issues (e.g., `Closes #123`).

## 5. Tooling
- **Script**: `./scripts/smart-commit.sh`
- **Usage**: `./scripts/smart-commit.sh -m "<type>: <msg>"`
- **Effect**: Creates a commit with the specified message. Does NOT bump version (handled by `release.sh`).
