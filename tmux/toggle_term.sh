#!/usr/bin/env bash

set -uo pipefail

STORE="_term"      # sessão detached onde os terminais ficam escondidos
SPLIT_SIZE="40"    # % da largura do split

win=$(tmux display-message -p '#{window_id}')          # @3 — estável
cwd=$(tmux display-message -p '#{pane_current_path}')
name="term${win#@}"                                     # term3

# ── O terminal desta janela está visível? ────────────
visible=$(tmux list-panes -t "$win" -F '#{pane_id} #{@is_term}' \
          | awk '$2=="1"{print $1; exit}')

if [ -n "$visible" ]; then
  # Esconde: manda para a sessão de storage
  tmux has-session -t "$STORE" 2>/dev/null \
    || tmux new-session -d -s "$STORE" -n _keep
  tmux break-pane -d -s "$visible" -n "$name" -t "$STORE:"
  exit 0
fi

# ── Recupera o terminal específico desta janela ──────
if tmux has-session -t "$STORE" 2>/dev/null \
   && tmux list-windows -t "$STORE" -F '#W' | grep -qx "$name"; then
  src=$(tmux list-panes -t "$STORE:$name" -F '#{pane_id}' | head -n1)
  tmux join-pane -h -l "${SPLIT_SIZE}%" -s "$src" -t "$win"
  tmux select-pane -t "$src"
else
  # ── Primeira vez nesta janela: cria no cwd dela ────
  new=$(tmux split-window -h -l "${SPLIT_SIZE}%" -c "$cwd" -t "$win" \
        -P -F '#{pane_id}')
  tmux set-option -p -t "$new" @is_term 1
  tmux select-pane -t "$new"
fi
