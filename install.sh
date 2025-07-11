#!/usr/bin/env bash
set -euo pipefail

# ── Preamble ──────────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script only supports macOS." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_URL="https://github.com/lambdaFunctions/Setup.git"
# Defaults to this checkout so `./install.sh`/`make` operate in place; set
# REPO_DIR to clone elsewhere (e.g. for a curl-and-run bootstrap).
REPO_DIR="${REPO_DIR:-$SCRIPT_DIR}"

log() {
  printf '\n\033[1;32m==>\033[0m %s\n' "$1"
}

require_brew() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is required. Run 'make homebrew' (or './install.sh homebrew') first." >&2
    exit 1
  fi
}

require_repo() {
  if [ ! -d "${REPO_DIR}" ]; then
    echo "Dotfiles repo not found at ${REPO_DIR}. Run 'make clone' (or './install.sh clone') first." >&2
    exit 1
  fi
}

# Appends $content to $file inside a marker-delimited block, skipping if
# that marker is already present — safe to re-run without duplicating.
append_block() {
  local marker="$1" file="$2" content="$3"
  touch "$file"
  if ! grep -qF "# >>> ${marker} >>>" "$file"; then
    {
      printf '\n# >>> %s >>>\n' "$marker"
      printf '%s\n' "$content"
      printf '# <<< %s <<<\n' "$marker"
    } >>"$file"
  fi
}

step_homebrew() {
  log "Homebrew"
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
  brew update
}

step_clone() {
  log "Cloning dotfiles repo into ${REPO_DIR}"
  if [ -d "${REPO_DIR}/.git" ]; then
    git -C "${REPO_DIR}" pull --ff-only
  else
    git clone "${REPO_URL}" "${REPO_DIR}"
  fi
}

step_fonts() {
  require_brew
  log "Fonts"
  brew install --cask font-meslo-lg-nerd-font font-symbols-only-nerd-font
}

step_git() {
  require_brew
  log "Git + Lazygit"
  brew install git lazygit
}

step_aerospace() {
  require_brew
  log "AeroSpace"
  brew install --cask aerospace
  cat <<'EOF'

Reminder: no AeroSpace config ships in this repo yet. Paste the following
gaps settings from the README into ~/.aerospace.toml:

[gaps]
inner.horizontal = 7
inner.vertical =   7
outer.left =       15
outer.bottom =     5
outer.top =        5
outer.right =      15

EOF
}

step_yazi() {
  require_brew
  log "Yazi"
  brew install yazi ffmpegthumbnailer ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick
  ya pkg add gosxrgxx/flexoki-dark
  mkdir -p "${HOME}/.config/yazi"
  cat >"${HOME}/.config/yazi/theme.toml" <<'EOF'
[flavor]
dark = "flexoki-dark"
EOF
}

step_docker() {
  require_brew
  log "Docker"
  brew install --cask docker-desktop
  brew install lazydocker
}

step_wezterm() {
  require_repo
  log "WezTerm"
  bash "${REPO_DIR}/wezterm/setup.sh"
}

step_nvim() {
  require_repo
  log "Neovim"
  bash "${REPO_DIR}/nvim/setup.sh"
}

step_tmux() {
  require_repo
  log "tmux"
  bash "${REPO_DIR}/tmux/setup.sh"
}

step_scripts() {
  require_repo
  log "scripts"
  bash "${REPO_DIR}/scripts/setup.sh"
}

step_zsh() {
  require_repo
  log "Zsh"
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  mkdir -p "${HOME}/.oh-my-zsh/themes"
  cp "${REPO_DIR}/zsh/paulo.zsh-theme" "${HOME}/.oh-my-zsh/themes/paulo.zsh-theme"

  touch "${HOME}/.zshrc"
  if grep -qE '^ZSH_THEME=' "${HOME}/.zshrc"; then
    sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="paulo"/' "${HOME}/.zshrc"
  else
    printf '\nZSH_THEME="paulo"\n' >>"${HOME}/.zshrc"
  fi

  append_block "setup-repo-zshrc" "${HOME}/.zshrc" "$(cat "${REPO_DIR}/zsh/zshrc")"

  # From README's Yazi section — not present in the repo's zshrc file itself.
  local yazi_cd_fn
  yazi_cd_fn=$(
    cat <<'EOF'
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
EOF
  )
  append_block "setup-yazi-cd-function" "${HOME}/.zshrc" "${yazi_cd_fn}"
}

step_summary() {
  log "Done"
  cat <<'EOF'

Next steps:
  - Open nvim once to let Mason install LSP servers, then run :checkhealth.
  - Paste the AeroSpace gaps settings above into ~/.aerospace.toml.
  - Launch Docker Desktop once manually to finish its setup.
  - Run `exec zsh` (or open a new terminal) to load the updated ~/.zshrc.
EOF
}

step_all() {
  step_homebrew
  step_clone
  step_fonts
  step_git
  step_aerospace
  step_yazi
  step_docker
  step_wezterm
  step_nvim
  step_tmux
  step_scripts
  step_zsh
  step_summary
}

case "${1:-all}" in
  all) step_all ;;
  homebrew) step_homebrew ;;
  clone) step_clone ;;
  fonts) step_fonts ;;
  git) step_git ;;
  aerospace) step_aerospace ;;
  yazi) step_yazi ;;
  docker) step_docker ;;
  wezterm) step_wezterm ;;
  nvim) step_nvim ;;
  tmux) step_tmux ;;
  scripts) step_scripts ;;
  zsh) step_zsh ;;
  *)
    echo "Usage: $0 [all|homebrew|clone|fonts|git|aerospace|yazi|docker|wezterm|nvim|tmux|scripts|zsh]" >&2
    exit 1
    ;;
esac
