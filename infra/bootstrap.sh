#!/usr/bin/env bash
set -euo pipefail
. /etc/os-release
if [[ "$ID" != ubuntu || "$VERSION_ID" != 24.04 ]]; then
  echo 'Este procedimiento requiere Ubuntu 24.04.' >&2
  exit 1
fi
free -h
df -h /
sudo apt-get update
sudo apt-get -s upgrade
if [[ "${1:-}" != apply ]]; then
  exit 0
fi
sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl git python3
if sudo docker info >/dev/null 2>&1 && sudo docker compose version; then
  exit 0
fi
for package in docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc; do
  if dpkg-query -W -f='${db:Status-Status}' "$package" 2>/dev/null | grep -qx installed; then
    echo "Revisar el paquete existente: $package" >&2
    exit 1
  fi
done
if [[ ! -e /etc/apt/sources.list.d/docker.sources ]]; then
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $VERSION_CODENAME
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
fi
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker info --format '{{.ServerVersion}}'
sudo docker compose version
