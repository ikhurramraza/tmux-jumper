#!/usr/bin/env bash

SCRIPTS_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

source "$SCRIPTS_DIRECTORY/helpers.sh"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#000000,bg:#000000,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

list-sessions() {
  local sessions="$(tmux list-sessions -F "#{session_name}" | sort)"

  grep -Fx main <<<"$sessions"
  grep -Fvx main <<<"$sessions"
}

main() {
  local new_session_script="$(get-tmux-option "@jumper-new-session-script" "$SCRIPTS_DIRECTORY/create_new_session.sh")"

  local sessions="$(list-sessions)"
  local current_session="$(tmux display-message -p '#S')"
  local current_position="$(grep -nFx "$current_session" <<<"$sessions" | cut -d: -f1)"

  local fzf_args=(--exit-0 --print-query --reverse)
  [[ -n "$current_position" ]] && fzf_args+=(--bind "load:pos($current_position)")

  local raw_result
  raw_result=$(fzf "${fzf_args[@]}" <<<"$sessions")
  local fzf_exit_code=$?

  local query="${raw_result%%$'\n'*}"
  local selection="${raw_result#*$'\n'}"
  [[ "$selection" == "$raw_result" ]] && selection=""

  case "$fzf_exit_code" in
  0)
    tmux switch-client -t "=$selection"
    ;;
  1)
    [[ -n "$query" ]] && tmux run-shell "$new_session_script $(printf '%q' "$query")"
    ;;
  esac
}

main
