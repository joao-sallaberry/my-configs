#!/usr/bin/env bash
# Copies the configs in this repo to their locations on the local machine,
# asking before overwriting each one.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux)  OS=linux ;;
    *)      OS=other ;;
esac

# source | destination | OS where it applies (all, macos, linux)
FILES="
.emacs               | $HOME/.emacs                | all
.gitconfig           | $HOME/.gitconfig            | all
hammerspoon/init.lua | $HOME/.hammerspoon/init.lua | macos
"

trim() { local s="$1"; s="${s#"${s%%[![:space:]]*}"}"; echo "${s%"${s##*[![:space:]]}"}"; }

install_file() {
    local src="$REPO_DIR/$1" dest="$2" answer

    if [ ! -e "$dest" ]; then
        read -r -p "Install $dest? [y/N] " answer
    elif cmp -s "$src" "$dest"; then
        echo "Up to date: $dest"
        return
    else
        while true; do
            read -r -p "Overwrite $dest? [y/N/d=show diff] " answer
            [ "$answer" = d ] || break
            diff -u "$dest" "$src" || true
        done
    fi

    case "$answer" in
        [yY]*)
            mkdir -p "$(dirname "$dest")"
            cp "$src" "$dest"
            echo "Copied $1 -> $dest"
            ;;
        *) echo "Skipped $dest" ;;
    esac
}

echo "Detected OS: $OS"
# The file list is read on fd 3 so stdin stays free for the prompts.
while IFS='|' read -r -u 3 src dest os; do
    src="$(trim "$src")"
    [ -n "$src" ] || continue
    dest="$(trim "$dest")"
    os="$(trim "$os")"

    if [ "$os" != all ] && [ "$os" != "$OS" ]; then
        echo "Not for $OS, skipping: $src"
        continue
    fi
    install_file "$src" "$dest"
done 3<<< "$FILES"
