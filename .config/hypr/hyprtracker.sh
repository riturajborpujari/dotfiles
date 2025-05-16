#!/usr/bin/env bash

echo "STARTING up with $XDG_RUNTIME_DIR, and $HYPRLAND_INSTANCE_SIGNATURE"

function handle {
  if [[ ${1:0:14} == "activewindow>>" ]]; then
    eww update activeWindow="${line/[a-z>]*,/}"
  else
      if [[ ${1:0:11} == "workspace>>" ]]; then
        eww update activeWorkspaceId="${1:11:2}"
      fi
  fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
