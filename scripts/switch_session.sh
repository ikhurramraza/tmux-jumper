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

  raw_result=$(fzf "${fzf_args[@]}" <<<"$sessions")

  local fzf_exit_code=$?

  IFS=$'\n' read -rd '' -a result <<<"$raw_result"

  local query="${result[0]}"
  local session_name="${result[1]}"

  # Cancelled fzf prompt using Ctrl-C
  [[ -z "$query" ]] && return 0

  if [[ $fzf_exit_code == 0 ]]; then
    [[ -z "$session_name" ]] && session_name="$query"

    tmux switch-client -t "$session_name"
  else
    tmux run "$new_session_script $query"
  fi
}

main
