#!/bin/bash

# CONFIGURATION - replace with your actual monitor names
INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-A-1"

# Get current monitor state
monitors=$(hyprctl monitors)

# Function: fetch best mode (resolution@refresh) for a monitor
get_best_mode() {
    local monitor=$1
    hyprctl monitors all | grep -A 1 "$monitor" | tail -n1 | awk '{print $1}'
}

# Function: set monitor with best mode and position
set_monitor_config() {
    local name=$1
    local mode=$2       # "preferred" or "off"
    local position=$3   # "" or "right-of <moni_tor>" or "same-as <monitor>"

    if [[ "$mode" == "disable" ]]; then
        hyprctl keyword monitor "$name, disable"
    else
        #local best_mode
        #best_mode=$(get_best_mode "$name")
        #if [[ -z "$position" ]]; then
        #hyprctl keyword monitor "$name, $mode, 0x0, 1"
        #else
        hyprctl keyword monitor "$name, $mode, $position, 1"
        #fi
    fi
}

# Keep track of current mode (using a temp file)
MODE_FILE="/tmp/hypr-monitor-mode"
if [ ! -f "$MODE_FILE" ]; then
    echo 0 > "$MODE_FILE"
fi

mode=$(cat "$MODE_FILE")

# Cycle through modes: 0 = internal, 1 = external, 2 = duplicate, 3 = side-by-side
case "$mode" in
    0)
        # Internal only
        set_monitor_config "$INTERNAL_MONITOR" "preferred" ""
        set_monitor_config "$EXTERNAL_MONITOR" "disable" ""
        new_mode=1
        ;;
    1)
        # External only
        set_monitor_config "$EXTERNAL_MONITOR" "preferred" ""
        set_monitor_config "$INTERNAL_MONITOR" "disable" ""
        new_mode=2
        ;;
    2)
        # Side-by-sidel
        set_monitor_config "$INTERNAL_MONITOR" "preferred" ""
        set_monitor_config "$EXTERNAL_MONITOR" "preferred" "auto-center-left"
        new_mode=0
        ;;
esac

# Save new mode
echo "$new_mode" > "$MODE_FILE"

