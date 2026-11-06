# Kitty Litter

Kitty Litter is a macOS menu-bar cleanup assistant. It puts files into quarantine first; permanent deletion is a separate, explicit action.

## First version

- Scans the signed-in user's `~/Library/Caches` and `~/Library/Logs` for regular files at least 1 MiB old enough to be considered stale (30 days).
- Scans `~/Downloads` for `.dmg`, `.pkg`, and `.zip` files at least 50 MiB and 60 days old.
- Skips hidden files and symbolic links and caps a scan at 5,000 candidates.
- Does not scan other users, external volumes, or system locations.
- Selecting **Pound into Quarantine** moves chosen files to `~/Library/Application Support/Kitty Litter/Quarantine`. The Quarantine tab can restore them to their original paths if those paths are clear.
- **Release Permanently** deletes selected quarantined files only after a confirmation dialog. It does not delete files directly from their original locations.
- Shows a low-space indicator below 20 GB free and scans at launch, on request, and every six hours while running.

## Build and run

```sh
make build
make run
```

The built app is `build/Kitty Litter.app` and requires macOS 13 or later.

## Optional login background app

The app can run at login as a per-user LaunchAgent. This is opt-in:

```sh
make install-agent
```

Remove the login item and copied app with:

```sh
make uninstall-agent
```

Uninstalling preserves the quarantine directory. Review and restore or permanently release its contents from Kitty Litter before removing that data yourself.
