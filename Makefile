SHELL := /bin/bash
.DEFAULT_GOAL := help

# Each target just forwards its name as a stage to install.sh, which is the
# single source of truth for what each stage actually does.
STAGES := all homebrew clone fonts git aerospace yazi docker wezterm nvim tmux scripts zsh

.PHONY: $(STAGES) help

$(STAGES):
	./install.sh $@

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "  all        Run the full setup (default entry point)"
	@echo "  homebrew   Install/update Homebrew"
	@echo "  clone      Clone this repo, or pull latest if already checked out"
	@echo "  fonts      Install Meslo + symbols-only Nerd Fonts"
	@echo "  git        Install Git + Lazygit"
	@echo "  aerospace  Install AeroSpace window manager"
	@echo "  yazi       Install Yazi + its flexoki-dark theme"
	@echo "  docker     Install Docker Desktop + Lazydocker"
	@echo "  wezterm    Install WezTerm (nightly) + deploy its config"
	@echo "  nvim       Install Neovim toolchain + deploy config + sync plugins"
	@echo "  tmux       Install tmux + deploy config + tpm"
	@echo "  scripts    Deploy helper scripts (docker-ps-formatter)"
	@echo "  zsh        Install Oh My Zsh + theme + deploy zshrc"
