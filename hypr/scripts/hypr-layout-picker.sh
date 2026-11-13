#!/usr/bin/env bash

# Define your available layouts
layouts="master\ndwindle\nmonocle\nscrolling"

# Launch rofi (or fuzzel -d / wofi --dmenu for Wayland)
chosen=$(echo -e "$layouts" | rofi -dmenu -p "Workspace Layout")

# Exit if nothing was selected
[[ -z "$chosen" ]] && exit 0

# Get the current active workspace ID
active_ws=$(hyprctl activeworkspace -j | jq -r '.id')

# Apply the layout rule dynamically using eval
hyprctl eval "hl.workspace_rule({ workspace = '$active_ws', layout = '$chosen' })"
