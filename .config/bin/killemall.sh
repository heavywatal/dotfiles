#!/bin/sh
set -x
ls -l ~/Library/Launch* /Library/Launch*
rm ~/Library/LaunchAgents/com.amazon.music.*
rm -f /Library/LaunchAgents/com.google.*
rm -f /Library/LaunchAgents/com.microsoft.update.*
rm -f /Library/LaunchDaemons/com.google.*
rm -f /Library/LaunchDaemons/com.microsoft.*
rm -f /Library/LaunchDaemons/us.zoom*
rm -rf "/Applications/Google Docs.app"
rm -rf "/Applications/Google Sheets.app"
rm -rf "/Applications/Google Slides.app"
rm "/Applications/Amazon Music.app/Contents/MacOS/Amazon Music Helper"
killall "Amazon Music Helper"
launchctl kill SIGKILL gui/501/com.amazon.music
launchctl bootout gui/501/com.amazon.music
