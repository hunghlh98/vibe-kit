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

    # Helper for safe copy (no overwrite)
    function safe_cp() {
        cp -n "$@" 2>/dev/null || true
    }
    function safe_cp_r() {
        cp -nr "$@" 2>/dev/null || true
    }

    # 2. Inject AGENTS.md (The Roster)
    if [ -f "$TEMPLATES_DIR/AGENTS.md" ]; then
        safe_cp "$TEMPLATES_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
    else 
        echo -e "${RED}Warning: templates/AGENTS.md not found.${NC}"
    fi

    # 3. Inject Documentation Templates
    safe_cp_r "$SKILLS_DIR/documentation/templates/"* "$TARGET_DIR/docs/"
    
    # NEW: Inject Scripts
    mkdir -p "$TARGET_DIR/scripts"
    if [ -d "$TEMPLATES_DIR/scripts" ]; then
        safe_cp "$TEMPLATES_DIR/scripts/"* "$TARGET_DIR/scripts/"
        chmod +x "$TARGET_DIR/scripts/"*.sh
    fi
    
    # 4. Inject Core Skills (Foundation + Documentation + Clean Architecture + Git Commit)
    safe_cp_r "$SKILLS_DIR/foundation" "$TARGET_DIR/.agent/skills/"
    safe_cp_r "$SKILLS_DIR/documentation" "$TARGET_DIR/.agent/skills/"
    safe_cp_r "$SKILLS_DIR/clean-architecture" "$TARGET_DIR/.agent/skills/"
    safe_cp_r "$SKILLS_DIR/git-commit" "$TARGET_DIR/.agent/skills/"

    # 5. Inject Specialized Skills & Workflows
    if [ "$PROJECT_TYPE" == "backend" ]; then
        safe_cp_r "$SKILLS_DIR/java" "$TARGET_DIR/.agent/skills/"
        # Copy backend-specific workflows
        [ -f "$WORKFLOWS_DIR/workflow-be.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-be.md" "$TARGET_DIR/.agent/workflows/"
        
    elif [ "$PROJECT_TYPE" == "frontend" ]; then
        safe_cp_r "$SKILLS_DIR/react-vite" "$TARGET_DIR/.agent/skills/"
        # Copy frontend-specific workflows
        [ -f "$WORKFLOWS_DIR/workflow-fe.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-fe.md" "$TARGET_DIR/.agent/workflows/"
    fi
    
    # Inject Common Workflows (BA, QA, DevOps, Git Commit)
    [ -f "$WORKFLOWS_DIR/workflow-ba.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-ba.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-qa.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-qa.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-devops.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-devops.md" "$TARGET_DIR/.agent/workflows/"
    [ -f "$WORKFLOWS_DIR/workflow-git-commit.md" ] && safe_cp "$WORKFLOWS_DIR/workflow-git-commit.md" "$TARGET_DIR/.agent/workflows/"
    
    # Inject Git Commit Skills Scripts
    if [ -d "$SKILLS_DIR/git-commit/scripts" ]; then
        safe_cp "$SKILLS_DIR/git-commit/scripts/"* "$TARGET_DIR/scripts/"
        chmod +x "$TARGET_DIR/scripts/"*.sh
    fi

    echo -e "${GREEN}✓ Brain Injection Complete (Skipped existing files).${NC}"
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
    if [ -z "$project_name" ]; then
        read -p "Project Directory (default: .): " project_dir
        project_dir=${project_dir:-.}
        
        if [ "$project_dir" == "." ]; then
             # Infer from current directory info
             local current_dir_name=$(basename "$PWD")
             echo "Using current directory: $current_dir_name"
             
             if [ -z "$artifact_id" ]; then
                 read -p "Artifact ID (default: $current_dir_name): " input_artifact
                 artifact_id=${input_artifact:-$current_dir_name}
             fi
             if [ -z "$group_id" ]; then
                 read -p "Group ID (e.g., com.mowise): " group_id
             fi
             if [ -z "$project_name" ]; then
                 project_name="$artifact_id"
             fi
        else
             # Use provided directory name as artifact_id by default
             if [ -z "$artifact_id" ]; then
                 artifact_id=$(basename "$project_dir")
             fi
             if [ -z "$group_id" ]; then
                 read -p "Group ID (e.g., com.mowise): " group_id
             fi
             if [ -z "$project_name" ]; then
                 project_name="$artifact_id"
             fi
        fi
    else
        # Arguments provided (e.g. from fullstack option)
        project_dir="$artifact_id"
    fi
    
    # Generate Spring Boot Project via API
    echo "Downloading Spring Boot Starter..."
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

    if [ "$project_dir" == "." ]; then
        echo "Unzipping to current directory..."
        unzip -q "$artifact_id.zip" -d temp_extract
        # Move contents of the inner folder to current dir
        # Spring zip usually has a root folder named after artifact_id
        if [ -d "temp_extract/$artifact_id" ]; then
            cp -n -r "temp_extract/$artifact_id/"* .
            rm -rf temp_extract
        else
            # Fallback if structure is different
            cp -n -r temp_extract/* .
            rm -rf temp_extract
        fi
    else
        echo "Unzipping to $project_dir..."
        unzip -q "$artifact_id.zip"
        # Since we downloaded as artifact_id.zip, unzip usually creates artifact_id/
        # If project_dir is different from artifact_id, we might need to properly handle it.
        # But for simplification, we assume standard behavior.
    fi
    rm "$artifact_id.zip"
    
    # Inject Brain
    if [ "$project_dir" == "." ]; then
        inject_antigravity_brain "." "backend"
    else
        inject_antigravity_brain "$artifact_id" "backend"
    fi

    # Initialize Git
    if [ ! -d ".git" ]; then
         if [ "$project_dir" != "." ]; then
             if [ -d "$artifact_id" ]; then
                  cd "$artifact_id"
                  git init -q
                  cd ..
             fi
         else
             git init -q
         fi
    fi

    echo -e "${GREEN}✓ Backend setup complete!${NC}"
}

function scaffold_frontend() {
    echo -e "\n${BLUE}⚛️ Initializing React Vite Project...${NC}"
    check_dependency "npm"

    local project_name=$1

    if [ -z "$project_name" ]; then
        read -p "Project Directory (default: .): " project_dir
        project_dir=${project_dir:-.}
        
        if [ "$project_dir" == "." ]; then
             echo "Using current directory."
             project_name="."
        else
             project_name="$project_dir"
        fi
    fi
    
    # Create Vite Project (React + TypeScript)
    # If project_name is ".", vite scaffolds in current dir
    # Use npx -y to avoid interactive prompts and potential script interruption
    npx -y create-vite@latest "$project_name" --template react-ts
    
    # Pushd/Popd to handle directory change safely
    pushd "$project_name" > /dev/null
    
    echo "Installing Dependencies..."
    npm install
    
    echo "Initializing Tailwind CSS v4 (@tailwindcss/vite)..."
    npm install tailwindcss @tailwindcss/vite@4.1.12
    npm install -D @types/node

    # Configure Vite for Tailwind v4 (Adapted from Mowise reference)
    echo "Configuring Vite..."
    cat > vite.config.ts <<EOF
import { defineConfig } from 'vite'
import path from 'path'
import tailwindcss from '@tailwindcss/vite'
import react from '@vitejs/plugin-react'
import { execSync } from 'child_process'
import pkg from './package.json'

// Attempt to get git info, fallback to package version
let commitHash = 'unknown'
let version = pkg.version

try {
  commitHash = execSync('git rev-parse --short HEAD').toString().trim()
  version = execSync('git describe --tags --abbrev=0').toString().trim()
} catch {
  console.log('Git info not available, using defaults')
}

// https://vitejs.dev/config/
export default defineConfig({
  define: {
    __APP_VERSION__: JSON.stringify(version),
    __COMMIT_HASH__: JSON.stringify(commitHash),
  },
  plugins: [
    react(),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
EOF

    # Configure CSS for Tailwind v4
    echo "Configuring CSS..."
    echo '@import "tailwindcss";' > src/index.css
    
    # Update tsconfig.app.json for alias (if it exists) to support @/
    if [ -f "tsconfig.app.json" ]; then
        # Simple sed to inject paths if not present (Not perfect but helps)
        # Ideally we'd use a json tool, but for bash script this is a quick patch
        # or we just rely on user to update tsconfig for the alias.
        echo "Note: You may need to update tsconfig.app.json 'paths' to support '@/*' alias."
    fi
    
    # Inject Brain (Using "." as target since we are inside the folder)
    inject_antigravity_brain "." "frontend"

    # Initialize Git if not already in a repo
    if [ ! -d "../.git" ] && [ ! -d ".git" ]; then
        git init -q
    fi
    
    popd > /dev/null
    
    echo -e "${GREEN}✓ Frontend setup complete!${NC}"
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