# Browser table, sourced by install.sh and uninstall.sh.
# Fields: profile dir (under ~/.config) | launcher binary | desktop file | process name
# Only brave is tested.
BROWSERS=(
  "brave|BraveSoftware/Brave-Browser|brave-browser-stable|brave-browser.desktop|brave"
  "chrome|google-chrome|google-chrome-stable|google-chrome.desktop|chrome"
  "chromium|chromium|chromium-browser|chromium-browser.desktop|chromium"
  "edge|microsoft-edge|microsoft-edge-stable|microsoft-edge.desktop|msedge"
  "vivaldi|vivaldi|vivaldi-stable|vivaldi-stable.desktop|vivaldi-bin"
)

# Usage: load_browser <name>; sets NAME PROFILE BIN DESKTOP PROC
load_browser() {
  local row
  for row in "${BROWSERS[@]}"; do
    IFS='|' read -r NAME PROFILE BIN DESKTOP PROC <<<"$row"
    [ "$NAME" = "$1" ] && return 0
  done
  echo "Unknown browser '$1'. Supported: brave chrome chromium edge vivaldi" >&2
  return 1
}
