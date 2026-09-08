#!/usr/bin/env bash

set -u

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

declare -A workspaces
active_workspace="1"
active_window_title="Desktop"

workspaces["1"]=1

update_eww() {
    local workspace_json

    workspace_json=$(
        printf '%s\n' "${!workspaces[@]}" |
            sort -V |
            jq -R -s 'split("\n") | map(select(length > 0))'
    )

    eww update \
        "workspaces=$workspace_json" \
        "activeWorkspace=$active_workspace" \
        "activeWindowTitle=$active_window_title"
}

initialize() {
    while read -r workspace; do
        workspaces["$workspace"]=1
    done < <(
        hyprctl workspaces -j |
            jq -r '.[].name'
    )

    active_workspace=$(
        hyprctl activeworkspace -j |
            jq -r '.name'
    )

    active_window_title=$(
        hyprctl activewindow -j |
            jq -r '.title // ""'
    )

    update_eww
}

handle_event() {
    local event="$1"
    local data="$2"

    case "$event" in
        workspace)
            active_workspace="$data"
            ;;

        createworkspace)
            workspaces["$data"]=1
            ;;

        destroyworkspace)
            unset 'workspaces[$data]'
            ;;

        activewindow)
            # Event format:
            # activewindow>>class,title
            active_window_title="${data#*,}"
            ;;

        *)
            return
            ;;
    esac

    update_eww
}

initialize

socat -u "UNIX-CONNECT:$SOCKET" - |
while IFS='>>' read -r line; do
	event="${line%%>*}"
	data="${line:$((${#event} + 2))}"
    handle_event "$event" "$data"
done
