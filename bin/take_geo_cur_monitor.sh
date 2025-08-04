#!/bin/bash
# Take geometry of the current focused monitor
hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"'
