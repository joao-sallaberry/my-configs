# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repo. There is no build, lint, or test suite. `./install.sh` copies each file to where its tool expects it, asking before each one (`y` copies, `d` shows a diff, anything else skips). It skips files that are already identical and files meant for another OS:

| Repo file | Deployed location | Tool |
|---|---|---|
| `.emacs` | `~/.emacs` | Emacs |
| `.gitconfig` | `~/.gitconfig` | Git |
| `hammerspoon/init.lua` | `~/.hammerspoon/init.lua` | Hammerspoon (macOS only) |

Editing a file here does not change the live config until `install.sh` is run again. To add a config, add a line to the `FILES` list in `install.sh` (`source | destination | all/macos/linux`) and to the table above. Keep the script compatible with bash 3.2, the version macOS ships with (so no associative arrays). Hammerspoon also needs "Reload Config" before changes take effect.

## Notes per file

- **`.emacs`**: loads the Solarized theme from `~/.emacs.d/themes/emacs-color-theme-solarized`, which is not in this repo, so the theme has to be cloned there separately. Prolog mode uses SWI-Prolog (`prolog-system 'swi`) and maps `.pl` to Prolog and `.m` to Mercury. The `custom-set-variables` / `custom-set-faces` blocks are managed by Emacs Customize, so avoid hand-editing them.
- **`.gitconfig`**: `core.editor` is `emacs -nw`. The `tracked` alias (`ls-tree -r master --name-only`) hardcodes the `master` branch.
- **`hammerspoon/init.lua`**: `cmd+shift+D` moves every visible window of the frontmost app to the next screen, cycling through `hs.screen.allScreens()`. The cycle index is a module-level variable, so it resets when the config reloads. If no windows move, Hammerspoon needs Accessibility permission (System Settings → Privacy & Security → Accessibility). You can check changes with Hammerspoon's console and the `move-app` logger.

## Conventions

- The main branch is `master`. Commit messages are short and imperative, often prefixed with the tool name (e.g. `Hammerspoon: ...`).
