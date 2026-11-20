# Browser table, sourced by install.sh and uninstall.sh.
# Fields: name | profile dir (relative to $HOME) | launcher to wrap | desktop file | process name
# Only brave is tested.
BROWSERS=(
  "brave|.config/BraveSoftware/Brave-Browser|/usr/bin/brave-browser-stable|/usr/share/applications/brave-browser.desktop|brave"
  "chrome|.config/google-chrome|/usr/bin/google-chrome-stable|/usr/share/applications/google-chrome.desktop|chrome"
  "chromium|.config/chromium|/usr/bin/chromium|/usr/share/applications/chromium.desktop|chromium"
  "chromium_snap|snap/chromium/common/chromium|/snap/bin/chromium|/var/lib/snapd/desktop/applications/chromium_chromium.desktop|chromium"
  "edge|.config/microsoft-edge|/usr/bin/microsoft-edge-stable|/usr/share/applications/microsoft-edge.desktop|msedge"
  "vivaldi|.config/vivaldi|/usr/bin/vivaldi-stable|/usr/share/applications/vivaldi-stable.desktop|vivaldi-bin"
)

# Usage: load_browser <name>; sets NAME PROFILE LAUNCHER DESKTOP_SRC PROC DESKTOP
load_browser() {
  local row want="${1//-/_}"
  for row in "${BROWSERS[@]}"; do
    IFS='|' read -r NAME PROFILE LAUNCHER DESKTOP_SRC PROC <<<"$row"
    if [ "$NAME" = "$want" ]; then DESKTOP=$(basename "$DESKTOP_SRC"); return 0; fi
  done
  echo "Unknown browser '$1'. Supported: brave chrome chromium chromium_snap edge vivaldi" >&2
  return 1
}
