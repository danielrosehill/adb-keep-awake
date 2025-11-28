# ADB Keep Awake

Simple scripts to prevent Android phones from sleeping while connected via USB, which can cause ADB to stop working.

## The Problem

When an Android phone is connected via USB and the display turns off after a few minutes, the device may enter a sleep/doze state that disables USB debugging, breaking ADB connectivity.

## Scripts

### `adb-keep-awake.sh` (Recommended)

Sets the Android system setting to keep the screen on while charging via USB. Run once and it persists until changed.

```bash
./adb-keep-awake.sh
```

This sets `stay_on_while_plugged_in=2` (USB mode). The phone will keep the screen on while connected via USB.

To revert:
```bash
adb shell settings put global stay_on_while_plugged_in 0
```

### `adb-keep-awake-monitor.sh` (Fallback)

If the settings approach doesn't work on your device, this script runs in the background and periodically sends a wake event to keep the device awake.

```bash
./adb-keep-awake-monitor.sh [interval_seconds]
```

Default interval is 60 seconds. Press Ctrl+C to stop.

## Quick One-Liner

If you just want to set it without the script:

```bash
# Enable stay awake on USB
adb shell settings put global stay_on_while_plugged_in 2

# Check current value
adb shell settings get global stay_on_while_plugged_in

# Disable (revert)
adb shell settings put global stay_on_while_plugged_in 0
```

### `stay_on_while_plugged_in` Values

| Value | Meaning |
|-------|---------|
| 0 | Never stay awake |
| 1 | AC charger only |
| 2 | USB only |
| 3 | AC + USB |
| 4 | Wireless charging |
| 7 | All charging methods |

## Requirements

- ADB installed and in PATH
- USB debugging enabled on your Android device
- Device connected and authorized

## License

MIT
