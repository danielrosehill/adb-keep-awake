#!/bin/bash
# ADB Keep Awake Script
# Prevents Android phone from sleeping while connected via USB
# This keeps the screen on while charging/USB connected

set -e

# Check if adb is available
if ! command -v adb &> /dev/null; then
    echo "Error: adb not found in PATH"
    exit 1
fi

# Wait for device
echo "Waiting for ADB device..."
adb wait-for-device

# Get device info
DEVICE=$(adb devices | grep -v "List" | grep "device$" | cut -f1)
if [ -z "$DEVICE" ]; then
    echo "Error: No device found"
    exit 1
fi

echo "Device connected: $DEVICE"

# Method 1: Set stay awake while charging (persists until changed)
# Values: 0=never, 1=AC, 2=USB, 3=AC+USB, 4=Wireless, 7=all
echo "Enabling 'Stay awake while charging via USB'..."
adb shell settings put global stay_on_while_plugged_in 2

# Method 2: Disable screen timeout temporarily (optional - uncomment if needed)
# This sets screen timeout to max (30 minutes typically)
# ORIGINAL_TIMEOUT=$(adb shell settings get system screen_off_timeout)
# echo "Original screen timeout: ${ORIGINAL_TIMEOUT}ms"
# adb shell settings put system screen_off_timeout 1800000

echo ""
echo "Done! Phone will stay awake while connected via USB."
echo ""
echo "To revert (disable stay awake):"
echo "  adb shell settings put global stay_on_while_plugged_in 0"
echo ""
echo "Current stay_on_while_plugged_in value:"
adb shell settings get global stay_on_while_plugged_in
