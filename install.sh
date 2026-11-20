#!/bin/bash
# Make Brave restore tabs after an unclean shutdown (Linux, Brave apt install).
set -e
mkdir -p ~/.local/bin ~/.local/share/applications

cat > ~/.local/bin/brave-clean <<'EOS'
#!/bin/bash
P="$HOME/.config/BraveSoftware/Brave-Browser/Default/Preferences"
if [ -f "$P" ] && ! pgrep -x brave >/dev/null; then
  sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/; s/"exited_cleanly":false/"exited_cleanly":true/' "$P"
fi
exec /usr/bin/brave-browser-stable "$@"
EOS
chmod +x ~/.local/bin/brave-clean

cp /usr/share/applications/brave-browser.desktop ~/.local/share/applications/
sed -i "s|^Exec=/usr/bin/brave-browser-stable|Exec=$HOME/.local/bin/brave-clean|" ~/.local/share/applications/brave-browser.desktop
update-desktop-database ~/.local/share/applications 2>/dev/null || true

grep '^Exec=' ~/.local/share/applications/brave-browser.desktop
echo "Done. Log out and back in once, then launch Brave from the app menu."
