#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. Deploy config ─────────────────────────────────────────────────────────
mkdir -p "${HOME}/.config"
rsync -a --exclude 'setup.sh' "${SCRIPT_DIR}/" "${HOME}/.config/nvim/"

# ── 2. Homebrew ──────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# ── 3. Core tools ────────────────────────────────────────────────────────────
# neovim >= 0.11 required for vim.lsp.enable()
# ripgrep + fd required for Telescope live_grep / find_files
brew install neovim git ripgrep fd yazi

# ── 4. Language runtimes ─────────────────────────────────────────────────────
brew install python3 node go

# clangd ships with llvm; also provides the C compiler used by nvim-treesitter
# to compile parsers — no separate tree-sitter CLI needed.
brew install llvm
export PATH="$(brew --prefix llvm)/bin:$PATH"

# Rust via rustup — manages rust-analyzer component cleanly
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
source "${HOME}/.cargo/env"
rustup component add rust-analyzer

# ── 5. Go tools (gopls + Delve DAP) ─────────────────────────────────────────
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# ── 6. Neovim plugins ────────────────────────────────────────────────────────
# lazy.nvim bootstraps itself on first launch (cloned by init.lua).
# This headless run installs all plugins and compiles treesitter parsers
# via the build = ":TSUpdate" hook — no manual TSInstall needed.
nvim --headless "+Lazy! sync" +qa

echo ""
echo "Done. Open nvim once to let Mason install LSP servers, then run :checkhealth."
