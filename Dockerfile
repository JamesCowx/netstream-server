# Stage 1: Build server
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ./*.sln ./
COPY Directory.Build.props ./
COPY Directory.Packages.props ./
COPY global.json ./
COPY SharedVersion.cs ./
COPY nuget.config ./

COPY Emby.Naming/*.csproj ./Emby.Naming/
COPY Emby.Photos/*.csproj ./Emby.Photos/
COPY Emby.Server.Implementations/*.csproj ./Emby.Server.Implementations/
COPY MediaBrowser.Common/*.csproj ./MediaBrowser.Common/
COPY MediaBrowser.Controller/*.csproj ./MediaBrowser.Controller/
COPY MediaBrowser.LocalMetadata/*.csproj ./MediaBrowser.LocalMetadata/
COPY MediaBrowser.MediaEncoding/*.csproj ./MediaBrowser.MediaEncoding/
COPY MediaBrowser.Model/*.csproj ./MediaBrowser.Model/
COPY MediaBrowser.Providers/*.csproj ./MediaBrowser.Providers/
COPY MediaBrowser.XbmcMetadata/*.csproj ./MediaBrowser.XbmcMetadata/
COPY NetStream.Api/*.csproj ./NetStream.Api/
COPY NetStream.Data/*.csproj ./NetStream.Data/
COPY NetStream.Server/*.csproj ./NetStream.Server/
COPY NetStream.Server.Implementations/*.csproj ./NetStream.Server.Implementations/
COPY src/NetStream.CodeAnalysis/*.csproj ./src/NetStream.CodeAnalysis/
COPY src/NetStream.Database/NetStream.Database.Implementations/*.csproj ./src/NetStream.Database/NetStream.Database.Implementations/
COPY src/NetStream.Database/NetStream.Database.Providers.Sqlite/*.csproj ./src/NetStream.Database/NetStream.Database.Providers.Sqlite/
COPY src/NetStream.Drawing/*.csproj ./src/NetStream.Drawing/
COPY src/NetStream.Drawing.Skia/*.csproj ./src/NetStream.Drawing.Skia/
COPY src/NetStream.Extensions/*.csproj ./src/NetStream.Extensions/
COPY src/NetStream.LiveTv/*.csproj ./src/NetStream.LiveTv/
COPY src/NetStream.MediaEncoding.Hls/*.csproj ./src/NetStream.MediaEncoding.Hls/
COPY src/NetStream.MediaEncoding.Keyframes/*.csproj ./src/NetStream.MediaEncoding.Keyframes/
COPY src/NetStream.Networking/*.csproj ./src/NetStream.Networking/

RUN dotnet restore NetStream.Server/NetStream.Server.csproj
COPY . .
RUN dotnet publish NetStream.Server/NetStream.Server.csproj -c Release -o /app --no-restore --self-contained false

# Copy web client dist into the publish output
COPY NetStream.Server/wwwroot/ /app/wwwroot/

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    fontconfig \
    libfontconfig1 \
    libfreetype6 \
    libssl3 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 -s /bin/bash netstream

WORKDIR /app
COPY --from=build /app ./

RUN mkdir -p /config /cache /media && \
    chown -R netstream:netstream /app /config /cache /media

VOLUME ["/config", "/cache", "/media"]

EXPOSE 8096 8920

USER netstream

ENV NETSTREAM_DATA_DIR=/config \
    NETSTREAM_CACHE_DIR=/cache \
    NETSTREAM_WEB_DIR=/app/netstream-web \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -sf http://localhost:8096/health > /dev/null || exit 1

ENTRYPOINT ["dotnet", "netstream.dll"]

