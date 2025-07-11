#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Needed by the `dps` alias in zshrc, which points at ~/.config/scripts/docker-ps-formatter
mkdir -p "${HOME}/.config/scripts"
cp "${SCRIPT_DIR}/docker-ps-formatter" "${HOME}/.config/scripts/docker-ps-formatter"
chmod +x "${HOME}/.config/scripts/docker-ps-formatter"

echo "scripts deployed to ~/.config/scripts."
