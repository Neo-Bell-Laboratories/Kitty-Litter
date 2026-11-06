#!/bin/sh
set -eu
PLIST="$HOME/Library/LaunchAgents/com.kensei.kitty-litter.plist"
DEST="$HOME/Applications/Kitty Litter.app"
if [ -f "$PLIST" ]; then
    launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true
    rm -f "$PLIST"
fi
rm -rf "$DEST"
echo "Removed Kitty Litter login item and installed app. Quarantine files were kept."
