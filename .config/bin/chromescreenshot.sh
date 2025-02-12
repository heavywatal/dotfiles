#!/bin/sh
set -eux
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
PNG="${2:-screenshot.png}"
WEBP="${PNG%.*}.webp"
"$chrome" --headless\
 --timeout=800\
 --virtual-time-budget=800\
 --window-size=600,536\
 --screenshot="$PNG"\
 "$1"
cwebp -lossless -crop 0 0 1200 900 -resize 600 450 "$PNG" -o "$WEBP"
