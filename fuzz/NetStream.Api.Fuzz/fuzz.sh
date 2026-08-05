#!/bin/sh

set -e

dotnet build -c Release ../../NetStream.Api/NetStream.Api.csproj --output bin
sharpfuzz bin/NetStream.Api.dll
cp bin/NetStream.Api.dll .

dotnet build
mkdir -p Findings
AFL_SKIP_BIN_CHECK=1 afl-fuzz -i "Testcases/$1" -o "Findings/$1" -t 5000 ./bin/Debug/net10.0/NetStream.Api.Fuzz "$1"
