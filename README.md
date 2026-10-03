# my-configs

Personal config files, kept here to set up a new machine quickly.

| File | Installed to | OS |
|---|---|---|
| `.emacs` | `~/.emacs` | all |
| `.gitconfig` | `~/.gitconfig` | all |
| `hammerspoon/init.lua` | `~/.hammerspoon/init.lua` | macOS |

## Install

```sh
git clone <this repo> && cd my-configs
./install.sh
```

The script goes through each file that applies to the current OS and asks before copying it:

- `y`: copy the file, overwriting the existing one (no backup is kept)
- `d`: show a diff between the installed file and the repo version, then ask again
- anything else: skip

Files that are already identical to the repo version are skipped without asking.

## Adding a file

Add a line to the `FILES` list at the top of `install.sh`:

```
source/path | $HOME/destination/path | all
```

The last column is `all`, `macos`, or `linux`.

## Extra setup

- **Emacs**: the Solarized theme is not in this repo. Clone it into `~/.emacs.d/themes/emacs-color-theme-solarized`.
- **Hammerspoon**: give Hammerspoon Accessibility permission (System Settings → Privacy & Security → Accessibility), then use "Reload Config". `cmd+shift+D` moves the frontmost app's windows to the next screen.
