#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SOURCE="$ROOT/build/Kitty Litter.app"
DEST="$HOME/Applications/Kitty Litter.app"
PLIST="$HOME/Library/LaunchAgents/com.kensei.kitty-litter.plist"
LABEL="com.kensei.kitty-litter"

if [ ! -d "$SOURCE" ]; then
    echo "Build the app first with make build" >&2
    exit 1
fi
mkdir -p "$HOME/Applications" "$HOME/Library/LaunchAgents"
if launchctl list "$LABEL" >/dev/null 2>&1; then launchctl bootout "gui/$(id -u)" "$PLIST" || true; fi
rm -rf "$DEST"
ditto "$SOURCE" "$DEST"
cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>Label</key><string>$LABEL</string>
<key>ProgramArguments</key><array><string>$DEST/Contents/MacOS/KittyLitter</string></array>
<key>RunAtLoad</key><true/>
<key>KeepAlive</key><false/>
</dict></plist>
EOF
launchctl bootstrap "gui/$(id -u)" "$PLIST"
echo "Installed Kitty Litter at login. Remove it with make uninstall-agent."
