#!/usr/bin/env bash

# Toggle Bluetooth connection for Sony WH-1000XM5
# Device MAC: AC:80:0A:CE:86:64

set -euo pipefail

DEVICE_MAC="AC:80:0A:CE:86:64"

# Make sure bluetooth is powered on
bluetoothctl power on >/dev/null

# Check current connection state
if bluetoothctl info "$DEVICE_MAC" | grep -q "Connected: yes"; then
    echo "Disconnecting $DEVICE_MAC..."
    bluetoothctl disconnect "$DEVICE_MAC"
else
    echo "Connecting $DEVICE_MAC..."
    bluetoothctl connect "$DEVICE_MAC"
fi
