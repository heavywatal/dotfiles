#!/bin/bash
set -eux
HOST=ftp.ncbi.nlm.nih.gov
[ "$(uname)" = "Darwin" ] && OS=mac || OS=linux-amd64
URL_PREFIX=https://${HOST}/pub/datasets/command-line/v2/${OS}
for cmd in datasets dataformat; do
  URL="${URL_PREFIX}/${cmd}"
  if ! DST=$(command -v "$cmd"); then
    PREFIX="${1:-${HOME}/.local/bin}"
    DST="${PREFIX}/${cmd}"
    mkdir -p "$PREFIX"
  fi
  TEMP=$(mktemp)
  curl -fsSL -z "$DST" -o "$TEMP" "$URL" && [ -s "$TEMP" ] && chmod +x "$TEMP" && mv "$TEMP" "$DST"
done
