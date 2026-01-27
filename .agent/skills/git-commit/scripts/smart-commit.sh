#!/bin/bash
set -e

# Usage: ./smart-commit.sh -m "commit message"

# 2. Commit Message Validation (Optional enhancement could go here)
# For now, we strictly wrap git commit to encourage usage, but we DO NOT bump versions.
# Versioning is handled by release.sh for BE/FE projects.

echo "Committing with: $@"

# 4. Git Commit
# Pass all arguments (like -m "msg") to git commit
git commit "$@"
