#!/bin/bash

VIDEO_DIR="$HOME/Videos"
AUDIO_DIR="$HOME/Music"

URL=$(xclip -selection clipboard -o 2>/dev/null)

if [[ -z "$URL" ]]; then
    notify-send "yt-dlp" "Clipboard is empty"
    exit 1
fi

if [[ ! "$URL" =~ ^https?:// ]]; then
    notify-send "yt-dlp" "Clipboard does not contain a valid URL"
    exit 1
fi

TYPE=$(printf "video\naudio" | dmenu -i -p "Download:")

[[ -z "$TYPE" ]] && exit 0



# Video

if [[ "$TYPE" == "video" ]]; then

    OPTION=$(printf \
        "Best quality\n1080p\n720p\n480p\n360p" |
        dmenu -i -p "Video quality:")

    [[ -z "$OPTION" ]] && exit 0

    case "$OPTION" in
        "Best quality")
            FORMAT="bestvideo+bestaudio/best"
            ;;

        "1080p")
            FORMAT="bestvideo[height<=1080]+bestaudio/best[height<=1080]"
            ;;

        "720p")
            FORMAT="bestvideo[height<=720]+bestaudio/best[height<=720]"
            ;;

        "480p")
            FORMAT="bestvideo[height<=480]+bestaudio/best[height<=480]"
            ;;

        "360p")
            FORMAT="bestvideo[height<=360]+bestaudio/best[height<=360]"
            ;;
    esac

    mkdir -p "$VIDEO_DIR"

    $TERMINAL -- bash -c '
        yt-dlp \
            -f "$1" \
            --merge-output-format mp4 \
            -o "$2/%(title)s.%(ext)s" \
            "$3"

        echo
        echo "Download finished."
        read -p "Press Enter to close..."
    ' _ "$FORMAT" "$VIDEO_DIR" "$URL"


# Audio


elif [[ "$TYPE" == "audio" ]]; then

    OPTION=$(printf \
        "MP3\nM4A\nOpus\nWAV" |
        dmenu -i -p "Audio format:")

    [[ -z "$OPTION" ]] && exit 0

    case "$OPTION" in
        "MP3")
            AUDIO_FORMAT="mp3"
            ;;

        "M4A")
            AUDIO_FORMAT="m4a"
            ;;

        "Opus")
            AUDIO_FORMAT="opus"
            ;;

        "WAV")
            AUDIO_FORMAT="wav"
            ;;
    esac

    mkdir -p "$AUDIO_DIR"

    $TERMINAL -- bash -c '
        yt-dlp \
            -x \
            --audio-format "$1" \
            -o "$2/%(title)s.%(ext)s" \
            "$3"

        echo
        echo "Download finished."
        read -p "Press Enter to close..."
    ' _ "$AUDIO_FORMAT" "$AUDIO_DIR" "$URL"

fi
