#!/bin/bash
# Make a Chromium-based browser restore tabs after an unclean shutdown (Linux).
# Usage: ./install.sh [brave|chrome|chromium|edge|vivaldi]   (default: brave)
set -e
cd "$(dirname "$0")"
. ./browsers.sh
load_browser "${1:-brave}"

WRAPPER="$HOME/.local/bin/$NAME-clean"
SYSTEM_DESKTOP="/usr/share/applications/$DESKTOP"
[ -f "$SYSTEM_DESKTOP" ] || { echo "$SYSTEM_DESKTOP not found, is $NAME installed from a package?" >&2; exit 1; }

mkdir -p ~/.local/bin ~/.local/share/applications

cat > "$WRAPPER" <<EOS
#!/bin/bash
P="\$HOME/.config/$PROFILE/Default/Preferences"
if [ -f "\$P" ] && ! pgrep -x $PROC >/dev/null; then
  sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/; s/"exited_cleanly":false/"exited_cleanly":true/' "\$P"
fi
exec /usr/bin/$BIN "\$@"
EOS
chmod +x "$WRAPPER"

cp "$SYSTEM_DESKTOP" ~/.local/share/applications/
sed -i "s|^Exec=/usr/bin/$BIN|Exec=$WRAPPER|" ~/.local/share/applications/"$DESKTOP"
update-desktop-database ~/.local/share/applications 2>/dev/null || true

grep '^Exec=' ~/.local/share/applications/"$DESKTOP"
echo "Done. Log out and back in once, then launch $NAME from the app menu."
