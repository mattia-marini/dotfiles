#!/usr/bin/env bash

CONFIG="$HOME/.config/cava/waybar_raw.conf"
ICONS=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

exec cava -p "$CONFIG" | tr '\0' ' ' | while read -r line; do
    out=""
    for v in $line; do
        idx=$(( v * ${#ICONS[@]} / 1000 ))
        (( idx < 0 )) && idx=0
        (( idx >= ${#ICONS[@]} )) && idx=$(( ${#ICONS[@]} - 1 ))
        out+="${ICONS[$idx]} "
    done
    echo "$out"
done