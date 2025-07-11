#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew &>/dev/null; then
  echo "Homebrew is required. Run install.sh first, or install Homebrew: https://brew.sh" >&2
  exit 1
fi

brew install tmux

mkdir -p "${HOME}/.config/tmux"
cp "${SCRIPT_DIR}/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
cp "${SCRIPT_DIR}/toggle_term.sh" "${HOME}/.config/tmux/toggle_term.sh"
chmod +x "${HOME}/.config/tmux/toggle_term.sh"

# tpm — tmux plugin manager, referenced by tmux.conf's plugin block
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [ ! -d "${TPM_DIR}" ]; then
  mkdir -p "${HOME}/.config/tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
fi
"${TPM_DIR}/bin/install_plugins"

echo "tmux installed and configured."
