#!/bin/sh
set -eux
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
options=(--headless --window-size=480,360)
if [ $# -lt 2 ]; then
  "$chrome" ${options[@]} --screenshot "$1"
else
  "$chrome" ${options[@]} --screenshot="$2" "$1"
fi
