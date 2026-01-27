#!/bin/bash
set -e

# Usage: ./smart-commit.sh -m "commit message"

# 1. Detect Version Source
VERSION_FILE="VERSION"
PACKAGE_JSON="package.json"
POM_XML="pom.xml"

CURRENT_VERSION="0.0.0"
VERSION_SOURCE=""

if [ -f "$VERSION_FILE" ]; then
    VERSION_SOURCE="FILE"
    CURRENT_VERSION=$(cat "$VERSION_FILE")
elif [ -f "$PACKAGE_JSON" ]; then
    VERSION_SOURCE="NPM"
    CURRENT_VERSION=$(node -p "require('./$PACKAGE_JSON').version")
elif [ -f "$POM_XML" ]; then
    VERSION_SOURCE="MAVEN"
    CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
else
    echo "No version source found (VERSION, package.json, or pom.xml). Initializing VERSION file."
    echo "1.0.0" > "$VERSION_FILE"
    VERSION_SOURCE="FILE"
    CURRENT_VERSION="1.0.0"
fi

echo "Current Version: $CURRENT_VERSION ($VERSION_SOURCE)"

# 2. Bump Patch Version logic
IFS='.' read -r major minor patch <<< "$CURRENT_VERSION"
# Handle cases like "1.0.0-SNAPSHOT" by stripping suffix for calculation if needed, 
# but for "smart commit" we usually just want simple semantic bumping.
# For robustness, let's keep it simple: strict semver required.
if [[ ! "$patch" =~ ^[0-9]+$ ]]; then
    # clean patch if it has suffix
    clean_patch=$(echo "$patch" | sed 's/[^0-9]*//g')
    if [ -z "$clean_patch" ]; then clean_patch=0; fi
    patch=$clean_patch
fi

new_patch=$((patch + 1))
NEW_VERSION="$major.$minor.$new_patch"

# 3. Apply Update
echo "Bumping to: $NEW_VERSION"

if [ "$VERSION_SOURCE" == "FILE" ]; then
    echo "$NEW_VERSION" > "$VERSION_FILE"
    git add "$VERSION_FILE"
elif [ "$VERSION_SOURCE" == "NPM" ]; then
    # npm version updates the file and git add/tag by default unless flags used
    # we want to control the commit, so --no-git-tag-version
    npm version "$NEW_VERSION" --no-git-tag-version
    git add "$PACKAGE_JSON" "package-lock.json" 2>/dev/null || true
elif [ "$VERSION_SOURCE" == "MAVEN" ]; then
    mvn versions:set -DnewVersion="$NEW_VERSION" -DgenerateBackupPoms=false
    git add "$POM_XML"
fi

# 4. Git Commit
# Pass all arguments (like -m "msg") to git commit
git commit "$@"
