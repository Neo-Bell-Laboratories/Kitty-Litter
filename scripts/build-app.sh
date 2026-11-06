#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
APP="$ROOT/build/Kitty Litter.app"
CONTENTS="$APP/Contents"

rm -rf "$APP"
mkdir -p "$CONTENTS/MacOS" "$CONTENTS/Resources"
cp "$ROOT/Resources/Info.plist" "$CONTENTS/Info.plist"
cp "$ROOT/Resources/AppIcon.icns" "$CONTENTS/Resources/AppIcon.icns"
swiftc -O -parse-as-library -target arm64-apple-macosx13.0 \
    -framework AppKit -framework SwiftUI \
    -o "$CONTENTS/MacOS/KittyLitter" "$ROOT/Sources/KittyLitter/KittyLitter.swift"
find "$APP" -name '._*' -type f -delete
codesign --force --deep --sign - "$APP"
printf 'Built %s\n' "$APP"
