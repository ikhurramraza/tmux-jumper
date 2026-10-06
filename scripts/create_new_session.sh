#!/usr/bin/env bash

main() {
  local session_name="$1"

  tmux has-session -t "=$session_name" 2>/dev/null || tmux new-session -d -s "$session_name"
  tmux switch-client -t "=$session_name"
}

main "$@"
