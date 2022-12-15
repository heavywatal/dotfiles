#!/bin/sh
set -eux
exiftool -all:all= -overwrite_original "$1"
qpdf --linearize --replace-input "$1"
