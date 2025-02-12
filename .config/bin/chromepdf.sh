#!/bin/sh
set -eux
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$chrome" --headless\
 --timeout=800\
 --virtual-time-budget=800\
 --no-pdf-header-footer\
 --print-to-pdf="${2:-output.pdf}"\
 "$1"
echo "WARNING: paper size is not A4 but US letter"
