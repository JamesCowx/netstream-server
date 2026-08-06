<h1 align="center">
  <br>
  <img src="NetStream.Server/wwwroot/api-docs/netstream.svg" alt="NetStream" width="420">
  <br>
  <br>
</h1>

<h3 align="center">The Free Software Media System</h3>

<p align="center">
  <a href="https://github.com/JamesCowx/netstream-server/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/JamesCowx/netstream-server?color=7c3aed"></a>
  <a href="https://github.com/JamesCowx/netstream-server/actions/workflows/ci-tests.yml"><img alt="Build" src="https://github.com/JamesCowx/netstream-server/actions/workflows/ci-tests.yml/badge.svg"></a>
  <a href="https://github.com/JamesCowx/netstream-server/actions/workflows/ci-format.yml"><img alt="Format" src="https://github.com/JamesCowx/netstream-server/actions/workflows/ci-format.yml/badge.svg"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-blueviolet">
  <img alt=".NET" src="https://img.shields.io/badge/.NET-10.0-%23512bd4">
</p>

---

NetStream is a **free and open-source** media server that puts you in control of managing and streaming your media. No strings attached, no premium licenses — just a powerful, self-hosted alternative to proprietary platforms.

---

## Features

- **Live TV** — Watch and record live television with DVR support
- **Hardware Acceleration** — Transcode media using VAAPI, NVENC, QSV, and more
- **Plugin System** — Extend functionality with a rich plugin ecosystem
- **Multi-User** — Create accounts for family and friends with fine-grained permissions
- **SyncPlay** — Watch content together in real-time with remote users
- **Metadata Management** — Automatic fetching of posters, art, and metadata
- **DLNA Support** — Stream to any DLNA-compatible device
- **Cross-Platform** — Runs on Windows, macOS, Linux, and Docker

## Quick Start

### Run with Docker

```bash
docker run -d \
  --name netstream \
  -p 8096:8096 \
  -v /path/to/config:/config \
  -v /path/to/media:/media:ro \
  netstream/netstream:latest
```

### Build from Source

**Prerequisites:** [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0)

```bash
# Clone the repo
git clone https://github.com/JamesCowx/netstream-server.git
cd netstream-server

# Clone and build the web client
git clone https://github.com/JamesCowx/netstream-web.git ../netstream-web
cd ../netstream-web && npm ci && npm run build:production && cd ../netstream-server
cp -r ../netstream-web/dist/* NetStream.Server/wwwroot/

# Run
dotnet run --project NetStream.Server -c Release
```

Open **http://localhost:8096** and follow the setup wizard.

### Deploy to Google Cloud VPS

```bash
curl -sSL https://raw.githubusercontent.com/JamesCowx/netstream-server/master/deploy-gcp.sh | bash
```

## Project Structure

```
netstream-server/
├── NetStream.Server/              # Main server entry point
├── NetStream.Api/                 # REST API controllers
├── NetStream.Data/                # Data access layer
├── NetStream.Server.Implementations/  # Core server logic
├── MediaBrowser.Controller/       # Media library management
├── MediaBrowser.Providers/        # Metadata providers
├── Emby.Naming/                   # File naming conventions
├── src/
│   ├── NetStream.Database/        # Database providers (SQLite)
│   ├── NetStream.Drawing/         # Image processing
│   ├── NetStream.LiveTv/          # Live TV & DVR
│   ├── NetStream.MediaEncoding/   # Transcoding pipeline
│   └── NetStream.Networking/      # Network utilities
├── tests/                         # Unit & integration tests
├── Dockerfile                     # Multi-stage Docker build
├── docker-compose.yml             # Docker Compose config
└── deploy-gcp.sh                  # GCP one-click deploy
```

## Contributing

We welcome contributions of all kinds — bug fixes, features, documentation, and translations.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

NetStream is licensed under the [GNU General Public License v2.0](LICENSE).

---

<p align="center">
  <sub>Built with care by the open-source community</sub>
</p>
