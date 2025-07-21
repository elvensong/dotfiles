#!/bin/bash

BATTERY_PATH=$(upower -e | grep keyboard)
if [ -n "$BATTERY_PATH" ]; then
  LEVEL=$(upower -i "$BATTERY_PATH" | grep percentage | awk '{print $2}')
  echo "$LEVEL"
else
  echo "N/A"
fi
