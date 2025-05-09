#!/bin/bash

# File path to conservation mode control
CONSERVATION_MODE_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

# Function to check conservation mode status
check_status() {
    STATUS=$(cat $CONSERVATION_MODE_PATH)
    if [ "$STATUS" -eq 1 ]; then
        echo "Conservation Mode is enabled."
    else
        echo "Conservation Mode is disabled."
    fi
}

# Function to enable conservation mode
enable_mode() {
    echo 1 > $CONSERVATION_MODE_PATH
    echo "Conservation Mode enabled."
}

# Function to disable conservation mode
disable_mode() {
    echo 0 > $CONSERVATION_MODE_PATH
    echo "Conservation Mode disabled."
}

# Options for dmenu
options="Check Status\nEnable\nDisable"

# Get the user's choice
choice=$(echo -e "$options" | dmenu -p "Conservation Mode:")

# Execute the corresponding function
case $choice in
    "Check Status")
        check_status
        ;;
    "Enable")
        enable_mode
        ;;
    "Disable")
        disable_mode
        ;;
    *)
        echo "Invalid option."
        ;;
esac
