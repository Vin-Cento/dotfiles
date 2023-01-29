#!/bin/sh

export BOOKMARKS="$HOME/dotfiles/bookmarks"
awk '{print $1}' "$BOOKMARKS" | rofi -dmenu -i | grep -f - "$BOOKMARKS" | cut --delimiter=" " --fields=2 | xclip -sel clipboard
