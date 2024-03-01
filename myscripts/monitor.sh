#!/bin/bash

gnome-terminal -- bash -c "btop; exec bash"

sleep 0.5
xdotool key Super+Up
