#!/bin/bash
# Usage: ./uninstall.sh [brave|chrome|chromium|edge|vivaldi]   (default: brave)
cd "$(dirname "$0")"
. ./browsers.sh
load_browser "${1:-brave}" || exit 1
rm -f ~/.local/share/applications/"$DESKTOP" ~/.local/bin/"$NAME-clean"
echo "Removed. The stock $NAME launcher is back."
