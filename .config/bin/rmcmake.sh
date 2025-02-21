#!/bin/sh
set -eux
cd "$1"
rm -r \
  CMakeCache.txt\
  CMakeFiles\
  CTestTestfile.cmake\
  DartConfiguration.tcl\
  Makefile\
  Testing\
  cmake_install.cmake\
  install_manifest.txt\

