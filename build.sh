#!/bin/bash
# Build NetStream Docker image locally and optionally push to registry
# Usage:
#   ./build.sh              # Build locally as netstream/netstream:latest
#   ./build.sh push         # Build and push to GCR
#   ./build.sh push gcr.io/MYPROJECT/netstream  # Push to specific registry

set -e
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE="netstream/netstream:latest"

# Ensure web client is built
WEB_DIR="$PROJECT_DIR/../netstream-web"
if [ ! -d "$WEB_DIR/dist" ]; then
    echo "Building web client..."
    cd "$WEB_DIR"
    npm ci
    npm run build:production
    cd "$PROJECT_DIR"
fi

# Copy web client to server wwwroot
echo "Syncing web client to server wwwroot..."
rm -rf "$PROJECT_DIR/NetStream.Server/wwwroot"/* 2>/dev/null || true
mkdir -p "$PROJECT_DIR/NetStream.Server/wwwroot"
cp -r "$WEB_DIR/dist/"* "$PROJECT_DIR/NetStream.Server/wwwroot/"

# Build Docker image
echo "Building Docker image: $IMAGE"
cd "$PROJECT_DIR"
docker build -t "$IMAGE" .

echo "Build complete: $IMAGE"

# Optional: Push to registry
if [ "$1" == "push" ]; then
    if [ -n "$2" ]; then
        REMOTE="$2"
        docker tag "$IMAGE" "$REMOTE:latest"
        docker push "$REMOTE:latest"
        echo "Pushed to $REMOTE:latest"
    else
        docker push "$IMAGE"
        echo "Pushed to $IMAGE"
    fi
fi

echo "Done!"
