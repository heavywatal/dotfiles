#!/bin/bash
set -eux
HOST=ftp.ncbi.nlm.nih.gov
[ "$(uname)" = "Darwin" ] && OS=mac || OS=linux-amd64
URL_PREFIX=https://${HOST}/pub/datasets/command-line/v2/${OS}
for cmd in datasets dataformat; do
  TEMP=$(mktemp)
  if DST=$(command -v "$cmd"); then
    if curl -z "$DST" -o "$TEMP" "${URL_PREFIX}/${cmd}" && [ -s "$TEMP" ]; then
      mv "$TEMP" "$DST"
    fi
  else
    DST="${1:-${HOME}/.local/bin}/${cmd}"
    curl -o "$TEMP" "${URL_PREFIX}/${cmd}" && mv "$TEMP" "$DST"
  fi
  [ ! -x "$DST" ] && chmod +x "$DST"
done
