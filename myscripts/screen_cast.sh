#!/bin/bash

OUTPUT_DIR="$HOME/Videos"

FILENAME="recording_$(date +'%Y%m%d_%H%M%S').mp4"

OUTPUT_FILE="$OUTPUT_DIR/$FILENAME"

mkdir -p "$OUTPUT_DIR"


ffmpeg \
    -video_size 1920x1080 \
    -framerate 60 \
    -f x11grab \
    -i :0.0 \
    -f pipewire \
    -i 0 \
    -f pipewire \
    -i 1 \
    -c:v libx264 \
    -c:a aac \
    -strict experimental \
    "$OUTPUT_FILE"
