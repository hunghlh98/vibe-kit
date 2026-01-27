#!/bin/bash

# ==============================================================================
# VIBE-KIT CLI
# Purpose: Scaffold Agentic Java/React projects with Antigravity structure.
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

# --- 1. CONFIGURATION & PATHS ---
VIBE_KIT_REPO="https://github.com/hunghlh98/vibe-kit.git"
VIBE_KIT_CACHE="$HOME/.vibe-kit/cache"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color



function fetch_assets() {
    # echo -e "${BLUE}📦 Checking Vibe Kit Assets...${NC}"
    mkdir -p "$VIBE_KIT_CACHE"
    
    if [ -d "$VIBE_KIT_CACHE/.git" ]; then
        pushd "$VIBE_KIT_CACHE" > /dev/null
        git fetch -q origin main
        local LOCAL=$(git rev-parse HEAD)
        local REMOTE=$(git rev-parse origin/main)
        
        if [ "$LOCAL" != "$REMOTE" ]; then
             echo -e "${BLUE}📦 New Vibe Kit version found. Updating...${NC}"
             git reset --hard -q origin/main
             echo -e "${GREEN}  ✓ Updated to latest.${NC}"
        fi
        popd > /dev/null
    else
        echo -e "${BLUE}📦 Installing Vibe Kit Assets...${NC}"
        git clone -q "$VIBE_KIT_REPO" "$VIBE_KIT_CACHE"
    fi
}

# Fetch assets immediately to ensure we have the latest core & version
fetch_assets

# Read Version from the freshly fetched cache
VERSION="Unknown"
if [ -f "$VIBE_KIT_CACHE/VERSION" ]; then
    VERSION=$(cat "$VIBE_KIT_CACHE/VERSION")
    VERSION=$(echo "$VERSION" | tr -d '\n')
fi

echo -e "${BLUE}🌌 VIBE-KIT v${VERSION}: Antigravity Agentic Scaffolder${NC}"
echo "=============================================="

# Set paths to cached assets
TEMPLATES_DIR="$VIBE_KIT_CACHE/templates"
SKILLS_DIR="$VIBE_KIT_CACHE/.agent/skills"
WORKFLOWS_DIR="$VIBE_KIT_CACHE/.agent/workflows"



# --- 2. HELPER FUNCTIONS ---

# --- NEW FUNCTION: Fetch External Skills ---
function fetch_external_skills() {
    echo -e "${BLUE}📦 Fetching External Skills...${NC}"
    
    # Clone UI-UX-Pro-Max if not present
    if [ ! -d "$SKILLS_DIR/frontend/ui-ux-pro-max" ]; then
        echo "  -> Cloning ui-ux-pro-max-skill..."
        git clone https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git \
            "$SKILLS_DIR/frontend/ui-ux-pro-max-temp" -q
            
        # Create a "Lite" version (React/Tailwind only) by moving core files
        mkdir -p "$SKILLS_DIR/frontend/ui-ux-pro-max"
        cp -r "$SKILLS_DIR/frontend/ui-ux-pro-max-temp/claude/skills/ui-ux-pro-max/"* \
              "$SKILLS_DIR/frontend/ui-ux-pro-max/"
        
        # Cleanup
        rm -rf "$SKILLS_DIR/frontend/ui-ux-pro-max-temp"
        echo -e "${GREEN}  ✓ ui-ux-pro-max (Lite) installed.${NC}"
    else
        echo "  -> ui-ux-pro-max already exists."
    fi
}

function check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: '$1' is not installed. Please install it to proceed.${NC}"
        exit 1
    fi
}

function inject_antigravity_brain() {
    local TARGET_DIR=$1
    local PROJECT_TYPE=$2

    echo -e "${BLUE}🧠 Injecting Antigravity Brain (${PROJECT_TYPE})...${NC}"

    # 1. Create Directory Structure
    mkdir -p "$TARGET_DIR/.agent/skills"
    mkdir -p "$TARGET_DIR/.agent/workflows"
    mkdir -p "$TARGET_DIR/.agent/memory"
    mkdir -p "$TARGET_DIR/docs/architecture"

    # 2. Inject AGENTS.md (The Roster)
    if [ -f "$TEMPLATES_DIR/AGENTS.md" ]; then
        cp "$TEMPLATES_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
    else 
        echo -e "${RED}Warning: templates/AGENTS.md not found.${NC}"
    fi

    # 3. Inject Documentation Templates
    cp -r "$SKILLS_DIR/documentation/templates/"* "$TARGET_DIR/docs/" 2>/dev/null || true
    
    # NEW: Inject Scripts
    mkdir -p "$TARGET_DIR/scripts"
    if [ -d "$TEMPLATES_DIR/scripts" ]; then
        cp "$TEMPLATES_DIR/scripts/"* "$TARGET_DIR/scripts/"
        chmod +x "$TARGET_DIR/scripts/"*.sh
    fi
    
    # 4. Inject Core Skills (Foundation + Documentation + Clean Architecture + Git Commit)
    cp -r "$SKILLS_DIR/foundation" "$TARGET_DIR/.agent/skills/"
    cp -r "$SKILLS_DIR/documentation" "$TARGET_DIR/.agent/skills/"
    cp -r "$SKILLS_DIR/clean-architecture" "$TARGET_DIR/.agent/skills/"
    cp -r "$SKILLS_DIR/git-commit" "$TARGET_DIR/.agent/skills/"

    # 5. Inject Specialized Skills & Workflows
    if [ "$PROJECT_TYPE" == "backend" ]; then
        cp -r "$SKILLS_DIR/java" "$TARGET_DIR/.agent/skills/"
        # Copy backend-specific workflows
        [ -f "$WORKFLOWS_DIR/workflow-be.md" ] && cp "$WORKFLOWS_DIR/workflow-be.md" "$TARGET_DIR/.agent/workflows/"
        
    elif [ "$PROJECT_TYPE" == "frontend" ]; then
        cp -r "$SKILLS_DIR/react-vite" "$TARGET_DIR/.agent/skills/"
        # Copy frontend-specific workflows
        [ -f "$WORKFLOWS_DIR/workflow-fe.md" ] && cp "$WORKFLOWS_DIR/workflow-fe.md" "$TARGET_DIR/.agent/workflows/"
    fi
    
    # Inject Common Workflows (BA, QA, DevOps, Git Commit)
    [ -f "$WORKFLOWS_DIR/workflow-ba.md" ] && cp "$WORKFLOWS_DIR/workflow-ba.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-qa.md" ] && cp "$WORKFLOWS_DIR/workflow-qa.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-devops.md" ] && cp "$WORKFLOWS_DIR/workflow-devops.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-git-commit.md" ] && cp "$WORKFLOWS_DIR/workflow-git-commit.md" "$TARGET_DIR/.agent/workflows/"
    
    # Inject Git Commit Skills Scripts
    if [ -d "$SKILLS_DIR/git-commit/scripts" ]; then
        cp "$SKILLS_DIR/git-commit/scripts/"* "$TARGET_DIR/scripts/" 2>/dev/null || true
        chmod +x "$TARGET_DIR/scripts/"*.sh
    fi

    echo -e "${GREEN}✓ Brain Injection Complete.${NC}"
}

function scaffold_backend() {
    echo -e "\n${BLUE}☕ Initializing Java Spring Boot Project...${NC}"
    
    # Check dependencies locally for this scope
    check_dependency "java"
    check_dependency "curl"
    check_dependency "unzip"

    local group_id=$1
    local artifact_id=$2
    local project_name=$3

    # If args not passed, ask for them
    if [ -z "$group_id" ]; then
        read -p "Group ID (e.g., com.mowise): " group_id
    fi
    if [ -z "$artifact_id" ]; then
        read -p "Artifact ID (e.g., backend): " artifact_id
    fi
    if [ -z "$project_name" ]; then
        read -p "Project Name (e.g., Mowise Backend): " project_name
    fi
    
    # Generate Spring Boot Project via API
    curl https://start.spring.io/starter.zip \
        -d type=maven-project \
        -d language=java \
        -d bootVersion=3.5.8 \
        -d javaVersion=21 \
        -d packaging=jar \
        -d groupId="$group_id" \
        -d artifactId="$artifact_id" \
        -d name="$project_name" \
        -d description="Agentic Backend for $project_name" \
        -d packageName="$group_id.$artifact_id" \
        -d dependencies=web,data-jpa,lombok,postgresql,validation,actuator,devtools \
        -o "$artifact_id.zip"

    echo "Unzipping..."
    unzip -q "$artifact_id.zip"
    rm "$artifact_id.zip"
    
    # Inject Brain
    inject_antigravity_brain "$artifact_id" "backend"

    # Initialize Git (if standalone, otherwise let parent handle it)
    # We will skip git init here if we are in a monorepo flow, but standard behaviour is fine
    # For simplicity, we'll let the user git init the root or subfolders as they wish.
    # But to follow previous logic:
    if [ ! -d ".git" ]; then
         cd "$artifact_id"
         git init -q
         cd ..
    fi

    echo -e "${GREEN}✓ Backend '$artifact_id' created successfully!${NC}"
}

function scaffold_frontend() {
    echo -e "\n${BLUE}⚛️ Initializing React Vite Project...${NC}"
    check_dependency "npm"

    local project_name=$1

    if [ -z "$project_name" ]; then
        read -p "Project Name (e.g., frontend): " project_name
    fi
    
    # Create Vite Project (React + TypeScript)
    npm create vite@latest "$project_name" -- --template react-ts
    
    # Pushd/Popd to handle directory change safely
    pushd "$project_name" > /dev/null
    
    echo "Installing Dependencies..."
    npm install
    
    echo "Initializing Tailwind CSS v4..."
    npm install -D tailwindcss postcss autoprefixer
    npx tailwindcss init -p
    
    # Fetch external skills (Disabled for strict vibe-kit)
    # fetch_external_skills
    
    # Inject Brain (Using "." as target since we are inside the folder)
    inject_antigravity_brain "." "frontend"

    # Initialize Git if not already in a repo
    if [ ! -d "../.git" ] && [ ! -d ".git" ]; then
        git init -q
    fi
    
    popd > /dev/null
    
    echo -e "${GREEN}✓ Frontend '$project_name' created successfully!${NC}"
}

# --- 3. MAIN LOGIC ---

echo "Select Project Type:"
echo "1) Backend (Java 21 + Spring Boot 3)"
echo "2) Frontend (React 18 + Vite)"
echo "3) Full Stack (Both)"
read -p "Enter choice [1/2/3]: " choice

if [ "$choice" == "1" ]; then
    scaffold_backend
    echo "  -> Next: cd <artifact-id> && ./mvnw clean install"

elif [ "$choice" == "2" ]; then
    scaffold_frontend
    echo "  -> Next: cd <project-name> && npm run dev"

elif [ "$choice" == "3" ]; then
    echo -e "\n${BLUE}🚀 Initializing Full Stack Project...${NC}"
    
    read -p "Group ID (e.g., com.mowise): " group_id
    # Default naming for monorepo
    scaffold_backend "$group_id" "backend" "Backend Service"
    scaffold_frontend "frontend"
    
    echo -e "\n${GREEN}✓ Full Stack Project created!${NC}"
    echo "Structure:"
    echo "  ├── backend/  (Java Spring Boot)"
    echo "  └── frontend/ (React Vite)"

else
    echo -e "${RED}Invalid choice. Exiting.${NC}"
    exit 1
fi