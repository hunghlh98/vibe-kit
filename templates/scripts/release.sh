#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}Starting Release Process...${NC}"

# 1. Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo -e "${RED}Error: Working directory is not clean. Please commit or stash changes.${NC}"
  exit 1
fi

# 2. Get current version and Project Name
# Detect if it's a Node or Java project
if [ -f "package.json" ]; then
    CURRENT_VERSION=$(node -p "require('./package.json').version")
    PROJECT_NAME=$(node -p "require('./package.json').name")
elif [ -f "pom.xml" ]; then
    # Use Maven to extract version and name reliably
    CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
    PROJECT_NAME=$(mvn help:evaluate -Dexpression=project.name -q -DforceStdout)
else
    echo "Unknown project type. Expected package.json or pom.xml"
    exit 1
fi

# Fallback if name is empty
if [ -z "$PROJECT_NAME" ]; then PROJECT_NAME="This Project"; fi

echo "Current Version: $CURRENT_VERSION"

# 3. Prompt for new version
read -p "Enter new version (e.g., 1.0.0): " NEW_VERSION
if [ -z "$NEW_VERSION" ]; then
  echo -e "${RED}Error: Version cannot be empty.${NC}"
  exit 1
fi

# 4. Update Version
echo "Updating version to $NEW_VERSION..."
if [ -f "package.json" ]; then
    npm version "$NEW_VERSION" --no-git-tag-version
elif [ -f "pom.xml" ]; then
    # Use Maven Versions Plugin for robust updates
    mvn versions:set -DnewVersion="$NEW_VERSION" -DgenerateBackupPoms=false
fi

# 5. Update Changelog
echo "Updating CHANGELOG.md..."
CHANGELOG_FILE="docs/CHANGELOG.md" # Changed to point to docs/
if [ ! -f "$CHANGELOG_FILE" ]; then CHANGELOG_FILE="CHANGELOG.md"; fi

LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

if [ -z "$LAST_TAG" ]; then
    RAW_COMMITS=$(git log --pretty=format:"%s" --no-merges)
else
    RAW_COMMITS=$(git log "${LAST_TAG}..HEAD" --pretty=format:"%s" --no-merges)
fi

ADDED_LOGS=""
CHANGED_LOGS=""
FIXED_LOGS=""

while IFS= read -r line; do
    if [ -z "$line" ]; then continue; fi
    
    if [[ "$line" =~ ^(feat|feat\() ]]; then
        ADDED_LOGS="${ADDED_LOGS}- ${line}"$'\n'
    elif [[ "$line" =~ ^(fix|fix\() ]]; then
        FIXED_LOGS="${FIXED_LOGS}- ${line}"$'\n'
    else
        CHANGED_LOGS="${CHANGED_LOGS}- ${line}"$'\n'
    fi
done <<< "$RAW_COMMITS"

COMMITS=""
if [ -n "$ADDED_LOGS" ]; then COMMITS="${COMMITS}### Added"$'\n'"${ADDED_LOGS}"$'\n'; fi
if [ -n "$CHANGED_LOGS" ]; then COMMITS="${COMMITS}### Changed"$'\n'"${CHANGED_LOGS}"$'\n'; fi
if [ -n "$FIXED_LOGS" ]; then COMMITS="${COMMITS}### Fixed"$'\n'"${FIXED_LOGS}"$'\n'; fi
if [ -z "$COMMITS" ]; then COMMITS="- No notable changes."; fi

DATE=$(date +%Y-%m-%d)
ENTRY_HEADER="## [v$NEW_VERSION] - $DATE"
ENTRY_CONTENT=$(printf "%s\n%s\n" "$ENTRY_HEADER" "$COMMITS")

if [ ! -f "$CHANGELOG_FILE" ]; then
    echo "# Changelog" > "$CHANGELOG_FILE"
    echo "" >> "$CHANGELOG_FILE"
    echo "All notable changes to **$PROJECT_NAME** will be documented in this file." >> "$CHANGELOG_FILE"
    echo "" >> "$CHANGELOG_FILE"
    echo "The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)," >> "$CHANGELOG_FILE"
    echo "and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)." >> "$CHANGELOG_FILE"
    echo "" >> "$CHANGELOG_FILE"
    echo "$ENTRY_CONTENT" >> "$CHANGELOG_FILE"
else
    FIRST_VERSION_LINE=$(grep -n "^## \[" "$CHANGELOG_FILE" | head -n 1 | cut -d: -f1)
    if [ -n "$FIRST_VERSION_LINE" ]; then
        TEMP_CHANGELOG="${CHANGELOG_FILE}.tmp"
        head -n "$((FIRST_VERSION_LINE - 1))" "$CHANGELOG_FILE" > "$TEMP_CHANGELOG"
        echo "$ENTRY_CONTENT" >> "$TEMP_CHANGELOG"
        echo "" >> "$TEMP_CHANGELOG"
        tail -n "+$FIRST_VERSION_LINE" "$CHANGELOG_FILE" >> "$TEMP_CHANGELOG"
        mv "$TEMP_CHANGELOG" "$CHANGELOG_FILE"
    else
        echo "" >> "$CHANGELOG_FILE"
        echo "$ENTRY_CONTENT" >> "$CHANGELOG_FILE"
    fi
fi

# 6. Build
echo "Building project..."
if [ -f "package.json" ]; then npm run build; fi
if [ -f "pom.xml" ]; then ./mvnw clean package -DskipTests; fi

# 7. Commit and Tag
echo "Committing release..."
TAG_NAME="v$NEW_VERSION"
git add .
git commit -m "chore: release $TAG_NAME"
git tag -a "$TAG_NAME" -m "Release $TAG_NAME"
git push origin --tags

echo -e "${GREEN}Release $TAG_NAME completed successfully!${NC}"

# 8. Deploy
echo ""
read -p "Do you want to deploy now? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "./scripts/deploy.sh" ]; then
        ./scripts/deploy.sh
    else
        echo -e "${RED}Error: deploy.sh not found.${NC}"
    fi
fi
