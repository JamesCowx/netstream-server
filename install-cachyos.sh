#!/bin/bash
# NetStream Auto-Installer for CachyOS (Arch-based, optimized)
set -e

GITHUB_USER="JamesCowx"
APP_DIR="/opt/netstream"
DATA_DIR="$HOME/netstream-data"
MEDIA_DIR="$HOME/media"

echo "============================================"
echo "  NetStream Installer for CachyOS"
echo "============================================"
echo ""

# Install deps
echo "[1/6] Installing dependencies..."
sudo pacman -S --needed --noconfirm docker git nodejs npm dotnet-sdk-10.0 aspnet-runtime-10.0 ffmpeg

sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker $USER

# Clone repos
echo "[2/6] Cloning repositories..."
sudo mkdir -p "$APP_DIR"
sudo chown $USER:$USER "$APP_DIR"

if [ ! -d "$APP_DIR/netstream-server" ]; then
    git clone "https://github.com/$GITHUB_USER/netstream-server.git" "$APP_DIR/netstream-server"
fi
if [ ! -d "$APP_DIR/netstream-web" ]; then
    git clone "https://github.com/$GITHUB_USER/netstream-web.git" "$APP_DIR/netstream-web"
fi

# Build web client
echo "[3/6] Building web client..."
cd "$APP_DIR/netstream-web"
npm ci --prefer-offline
npm run build:production

# Sync web client to server
echo "[4/6] Syncing web client..."
rm -rf "$APP_DIR/netstream-server/NetStream.Server/wwwroot"/*
mkdir -p "$APP_DIR/netstream-server/NetStream.Server/wwwroot"
cp -r dist/* "$APP_DIR/netstream-server/NetStream.Server/wwwroot/"

# Build Docker
echo "[5/6] Building Docker image..."
cd "$APP_DIR/netstream-server"
docker build -t netstream/cachyos .

# Create data dirs
mkdir -p "$DATA_DIR" "$MEDIA_DIR"

# Stop old container
docker rm -f netstream 2>/dev/null || true

# Run optimized
echo "[6/6] Starting NetStream..."
docker run -d \
    --name netstream \
    --restart unless-stopped \
    --cpuset-cpus="0-$(($(nproc)-1))" \
    --memory="4g" \
    -p 8096:8096 \
    -v "$DATA_DIR:/config" \
    -v "$MEDIA_DIR:/media:ro" \
    -e TZ="$(timedatectl show --property=Timezone --value)" \
    -e DOTNET_GCHeapHardLimit=1C0000000 \
    -e DOTNET_GCDynamicAdaptationMode=1 \
    -e DOTNET_EnableWriteXorExecute=0 \
    -e COMPlus_EnableWriteXorExecute=0 \
    netstream/cachyos

sleep 4
IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1 | head -1)

echo ""
echo "============================================"
echo "  NetStream is LIVE!"
echo "  Local:  http://localhost:8096"
echo "  Network: http://${IP}:8096"
echo ""
echo "  Data:   $DATA_DIR"
echo "  Media:  $MEDIA_DIR"
echo "  Logs:   docker logs -f netstream"
echo "============================================"
