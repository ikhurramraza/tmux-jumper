#!/usr/bin/env bash

main() {
  local session_name="$1"

  tmux new-session -d -s "$session_name"
  tmux switch-client -t "$session_name"
}

main "$@"
