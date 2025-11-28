#!/bin/bash
# ADB Keep Awake Monitor
# Runs in background and periodically ensures device stays awake
# Use this if the simpler settings approach doesn't work

INTERVAL=${1:-60}  # Check every 60 seconds by default

cleanup() {
    echo "Stopping keep-awake monitor..."
    exit 0
}

trap cleanup SIGINT SIGTERM

echo "ADB Keep Awake Monitor"
echo "Checking device every ${INTERVAL} seconds"
echo "Press Ctrl+C to stop"
echo ""

while true; do
    # Check if device is connected
    if adb get-state &>/dev/null; then
        # Send a harmless input event to keep device awake
        # This simulates a very brief touch that doesn't actually do anything visible
        adb shell input keyevent KEYCODE_WAKEUP 2>/dev/null || true

        # Alternative: just ping the device to maintain connection
        # adb shell echo "ping" >/dev/null 2>&1

        echo "[$(date '+%H:%M:%S')] Device alive"
    else
        echo "[$(date '+%H:%M:%S')] Device disconnected or ADB unavailable"
    fi

    sleep "$INTERVAL"
done
