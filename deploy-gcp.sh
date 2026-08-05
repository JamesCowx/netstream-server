#!/bin/bash
# NetStream GCP Deployment - Clone from GitHub & Run
# Run on your GCP VPS (Ubuntu/Debian)
set -e

GITHUB_USER="JamesCowx"
SERVER_REPO="https://github.com/${GITHUB_USER}/netstream-server.git"
WEB_REPO="https://github.com/${GITHUB_USER}/netstream-web.git"
APP_DIR="/opt/netstream"

echo "=== NetStream GCP Deployment ==="

# 1. Install Docker & Git
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh
    sudo usermod -aG docker $USER
    newgrp docker <<'DOCKER'
        set -e
        DOCKER
fi

sudo apt-get update && sudo apt-get install -y git curl

# 2. Clone repos
echo "Cloning NetStream..."
sudo mkdir -p "$APP_DIR"
sudo chown $USER:$USER "$APP_DIR"
cd "$APP_DIR"

if [ ! -d "netstream-server" ]; then
    git clone "$SERVER_REPO" netstream-server
fi
if [ ! -d "netstream-web" ]; then
    git clone "$WEB_REPO" netstream-web
fi

# 3. Build web client
echo "Building web client..."
cd "$APP_DIR/netstream-web"
npm ci --production
npm run build:production

# 4. Copy web client to server
echo "Syncing web client..."
rm -rf "$APP_DIR/netstream-server/NetStream.Server/wwwroot"/*
mkdir -p "$APP_DIR/netstream-server/NetStream.Server/wwwroot"
cp -r dist/* "$APP_DIR/netstream-server/NetStream.Server/wwwroot/"

# 5. Build Docker image
echo "Building Docker image..."
cd "$APP_DIR/netstream-server"
docker build -t netstream/netstream:latest .

# 6. Create data dirs
sudo mkdir -p /opt/netstream/data /opt/netstream/cache /opt/netstream/media
sudo chown -R $USER:$USER /opt/netstream/data /opt/netstream/cache /opt/netstream/media

# 7. Run NetStream
echo "Starting NetStream..."
docker rm -f netstream 2>/dev/null || true
docker run -d \
    --name netstream \
    --restart unless-stopped \
    -p 8096:8096 \
    -v /opt/netstream/data:/config \
    -v /opt/netstream/cache:/cache \
    -v /opt/netstream/media:/media:ro \
    -e TZ=America/New_York \
    netstream/netstream:latest

# 8. Done
sleep 5
IP=$(curl -s ifconfig.me)
echo ""
echo "============================================"
echo "  NetStream is LIVE!"
echo "  URL: http://${IP}:8096"
echo ""
echo "  Config:  /opt/netstream/data"
echo "  Media:   /opt/netstream/media"
echo "  Logs:    docker logs -f netstream"
echo "============================================"
