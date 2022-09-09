#!/bin/sh
set -eux
HTML=${1##*/}
PDF=${HTML%.*}.pdf
npm run decktape $1 $PDF
