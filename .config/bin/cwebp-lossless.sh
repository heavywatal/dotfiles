#!/bin/sh
parallel -u cwebp -lossless "{}" -o "{.}.webp" ::: "$@"
