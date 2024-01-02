#!/usr/bin/env bash

SCRIPTS_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/scripts"

source "$SCRIPTS_DIRECTORY/helpers.sh"

main() {
  local key="$(get-tmux-option "@jumper-key" "C-\\")"
  local key_without_prefix="$(get-tmux-option "@jumper-key-without-prefix" "true")"

  local width="$(get-tmux-option "@jumper-popup-width" 75)"
  local height="$(get-tmux-option "@jumper-popup-height" 10)"
  local y_position="$(get-tmux-option "@jumper-popup-y-position" 15)"

  local arguments=()

  if [[ "$key_without_prefix" = "true" ]]; then
    arguments+=("-n")
  fi

  tmux bind-key "${arguments[@]}" "$key" display-popup -w $width -h $height -y $y_position -E "$SCRIPTS_DIRECTORY/switch_session.sh"
}

main
