#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew &>/dev/null; then
  echo "Homebrew is required. Run install.sh first, or install Homebrew: https://brew.sh" >&2
  exit 1
fi

# WezTerm nightly — README has no wezterm section yet; this is the only
# maintained way to track WezTerm's latest features/fixes on macOS.
brew install --cask wezterm@nightly

mkdir -p "${HOME}/.config/wezterm"
cp "${SCRIPT_DIR}/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"

echo "WezTerm (nightly) installed and configured."
