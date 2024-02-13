#!/bin/bash
set -eux
HOST=hgdownload.soe.ucsc.edu
[ "$(uname)" = "Darwin" ] && OS=macOSX || OS=linux
SRC=rsync://${HOST}/genome/admin/exe/${OS}.$(uname -m)/
DST="${1:-$UCSC_KENT_BIN}"
rsync -auvC\
 --exclude="*Psl" \
 --include="README*"\
 --include="axt*"\
 --include="bedGraphToBigWig"\
 --include="bigWig*"\
 --include="chain*"\
 --include="fa*"\
 --include="lift*"\
 --include="maf*"\
 --include="mask*"\
 --include="net*"\
 --include="twoBitInfo"\
 --include="wigToBigWig"\
 --exclude="*" \
 $SRC "$DST"
