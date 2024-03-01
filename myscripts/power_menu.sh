#!/bin/bash

# Outputting choices to rofi in dmenu mode
choice=$(echo -e "exit\nshutdown\nreboot\nsuspend\nlogout" | dmenu -fn "$dmenufont" -p "power menu ")
["$choice" = "exit"] && exit 
[ "$choice" = "shutdown" ] && poweroff
[ "$choice" = "reboot" ] && reboot
[ "$choice" = "suspend" ] && systemctl suspend -i
[ "$choice" = "logout" ] && loginctl terminate-user "$USER" 
