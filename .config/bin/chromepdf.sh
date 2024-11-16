#!/bin/sh
set -eux
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
options=(--headless --run-all-compositor-stages-before-draw --no-pdf-header-footer)
if [ $# -lt 2 ]; then
  "$chrome" ${options[@]} --print-to-pdf "$1"
else
  "$chrome" ${options[@]} --print-to-pdf="$2" "$1"
fi
echo "WARNING: paper size is not A4 but US letter"
