#!/bin/bash

# Mute the microphone
amixer set Capture toggle

# Check if the microphone is muted or not
mute_status=$(amixer get Capture | grep -o "\[off\]")

# Display notification
if [ -n "$mute_status" ]; then
    notify-send "Microphone Muted"
else
    notify-send "Microphone Unmuted"
fi

