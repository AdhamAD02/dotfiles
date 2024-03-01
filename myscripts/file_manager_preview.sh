#!/bin/bash

DIR="$HOME"

while true; do

    FILES=$(ls -1 "$DIR")

    if [ "$DIR" != "$HOME" ]; then
        FILES="Go back\n$FILES"
    fi

    SELECTED_ITEM=$(echo -e "$FILES" | dmenu -l 8 -fn 'dmenufont' -p "$DIR: " || exit)

    if [ "$SELECTED_ITEM" == "Go back" ]; then
        DIR=$(dirname "$DIR")
    else
        if [ -n "$SELECTED_ITEM" ]; then
            if [ -d "$DIR/$SELECTED_ITEM" ]; then
                DIR="$DIR/$SELECTED_ITEM"
            else
                xdg-open "$DIR/$SELECTED_ITEM" >/dev/null 2>&1 &
            fi
        else
            break
        fi
    fi
done

