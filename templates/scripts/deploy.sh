#!/bin/bash

# Configuration (TODO: Update these values)
SERVER_USER="user"
SERVER_HOST="host"
SERVER_PATH="/path/to/app"

# Build
echo "Building for production..."
# Detect project type (Maven or NPM)
if [ -f "pom.xml" ]; then
    ./mvnw clean package -DskipTests
elif [ -f "package.json" ]; then
    npm run build
fi

# Deploy
echo "Deploying to $SERVER_HOST..."
# Ensure you have SSH access configured
rsync -avz --delete dist docker-compose.yml nginx.conf $SERVER_USER@$SERVER_HOST:$SERVER_PATH

# Reload Docker
echo "Reloading Docker Compose on server..."
ssh $SERVER_USER@$SERVER_HOST "cd $SERVER_PATH && docker compose up -d --force-recreate"

echo "Deployment complete!"
