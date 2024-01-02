#!/usr/bin/env bash

get-tmux-option() {
  local option_name="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option_name")"

  [ -n "$option_value" ] && echo "$option_value" || echo "$default_value"
}
