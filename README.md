# chromium-linux-restore-pages-fix

Fixes the "Restore pages? Brave didn't shut down correctly" prompt on Linux.

If you shut down, reboot or log out with the browser still open, the next start
shows a restore prompt or an empty window, even though nothing crashed. This
resets the crash flag before each launch, so your tabs come back on their own.

Tested on Ubuntu with Brave from the apt repo.

## The problem

After an unclean exit, Chromium-based browsers show one of these:

- `Restore pages? Brave didn't shut down correctly.`
- `Restore pages? Chromium didn't shut down correctly.`
- `Google Chrome didn't shut down correctly.`
- An empty window, so you have to click **Restore** to get your tabs back.

## Why it happens

The session ends before the browser has finished a clean exit. Chromium then
leaves `"exit_type":"Crashed"` in the profile's `Preferences` file and treats
the next start as crash recovery. Your session data is normally intact.

The logic is in Chromium, so other Chromium-based browsers (Chrome, Chromium,
Edge, Vivaldi, Opera) should behave the same way. I only tested Brave.

## The fix

Before each launch, a small wrapper sets `exit_type` back to `Normal` and
`exited_cleanly` back to `true`, then starts the browser. With **Continue where
you left off** enabled, your tabs restore automatically and no prompt is shown.

## Requirements

- Linux with GNOME-style desktop launchers
- Brave from the apt repo (`/usr/bin/brave-browser-stable`)
- Startup set to **Continue where you left off** (`brave://settings/getStarted`)

## Install

Run as your normal user, not with sudo:

    ./install.sh

Then log out and back in once and launch Brave from the app menu.

## Uninstall

    ./uninstall.sh

## Other browsers

Change the profile path and launcher in `install.sh`, for example
`~/.config/google-chrome` for Chrome or `~/.config/chromium` for Chromium.

## Notes

- Only the `Default` profile is fixed.
- The launcher copy overrides the system one, so it won't pick up launcher
  changes from Brave updates.
- If the browser is killed while writing session data, the last few seconds of
  tab changes can still be lost.
