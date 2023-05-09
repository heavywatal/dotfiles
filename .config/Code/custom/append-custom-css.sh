#!/bin/sh
set -eux
RESOURCES="/Applications/Visual Studio Code.app/Contents/Resources"
MAIN_CSS="${RESOURCES}/app/out/vs/workbench/workbench.desktop.main.css"
CUSTOM_CSS="$(dirname ${0})/custom.css"
[ -f "$MAIN_CSS" ] || exit 1
[ -f "$CUSTOM_CSS" ] || exit 1
grep -q "custom\.css" "$MAIN_CSS" && exit 0
cat "$CUSTOM_CSS" >> "$MAIN_CSS"
