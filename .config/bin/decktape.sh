#!/bin/sh
set -eux
URL=$1
PDF=${URL%%/}
PDF=${PDF##*/}
PDF=${PDF%.*}.pdf
echo npm run decktape $URL $PDF
