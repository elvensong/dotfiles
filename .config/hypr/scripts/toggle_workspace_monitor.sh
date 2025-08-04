#!/usr/bin/env sh

# Cycling workspace between active monitors

# Get current workspace ID
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
# Get current monitor ID
current_monitor=$(hyprctl activeworkspace -j | jq '.monitorID')

# Determine target monitor
target_monitor=$((1 - current_monitor))

hyprctl dispatch movecurrentworkspacetomonitor "$target_monitor"
