#!/bin/sh
set -eux
URL=$1
PDF=${URL%%/}
PDF=${PDF##*/}
PDF=${PDF%.*}.pdf
npx decktape -s 960x720 --chrome-arg=--disable-web-security reveal "$URL" "$PDF"
