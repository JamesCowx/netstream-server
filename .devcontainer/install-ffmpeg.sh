#!/bin/bash

## configure the following for a manual install of a specific version from the repo

# wget https://repo.netstream.org/releases/server/ubuntu/versions/netstream-ffmpeg/6.0.1-1/netstream-ffmpeg6_6.0.1-1-jammy_amd64.deb -O ffmpeg.deb

# sudo apt update
# sudo apt install -f ./ffmpeg.deb -y
# rm ffmpeg.deb


## Add the netstream repo
sudo apt install curl gnupg -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe -y

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.netstream.org/netstream_team.gpg.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/netstream.gpg
export VERSION_OS="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
export VERSION_CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
export DPKG_ARCHITECTURE="$( dpkg --print-architecture )"
cat <<EOF | sudo tee /etc/apt/sources.list.d/netstream.sources
Types: deb
URIs: https://repo.netstream.org/${VERSION_OS}
Suites: ${VERSION_CODENAME}
Components: main
Architectures: ${DPKG_ARCHITECTURE}
Signed-By: /etc/apt/keyrings/netstream.gpg
EOF

sudo apt update -y
sudo apt install netstream-ffmpeg7 -y
