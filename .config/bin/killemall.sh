#!/bin/sh
set -x
ls -l ~/Library/Launch* /Library/Launch*

rm -f ~/Library/LaunchAgents/com.google.*
rm -f /Library/Launch*/com.google.*
rm -f /Library/Launch*/com.microsoft.*
rm -f /Library/Launch*/us.zoom*
rm -rf "/Applications/Google Docs.app"
rm -rf "/Applications/Google Sheets.app"
rm -rf "/Applications/Google Slides.app"

if [ -e "/Applications/Amazon Music.app" ]; then
  rm -f ~/Library/LaunchAgents/com.amazon.music.*
  rm -f "/Applications/Amazon Music.app/Contents/MacOS/Amazon Music Helper"
  killall "Amazon Music Helper"
  launchctl kill SIGKILL gui/501/com.amazon.music
  launchctl bootout gui/501/com.amazon.music
fi
