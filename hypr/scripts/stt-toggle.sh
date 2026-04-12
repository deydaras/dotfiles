#!/usr/bin/env bash

set -euo pipefail

# Change these if your setup uses different names/paths.
RECORD_CMD="/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"
PID_MATCH="hyprwhspr-tray.sh record"

# Optional: if your speech-to-text tool writes the final text to a file,
# put the path here and uncomment the file-based paste section below.
# TRANSCRIPT_FILE="$HOME/.local/share/hyprwhspr/latest_transcript.txt"

# Detect whether recording is active.
if pgrep -f "$PID_MATCH" >/dev/null; then
    # Stop active recording.
    pkill -f "$PID_MATCH"

    # Small delay so the backend can finalize the transcript.
    sleep 0.4

    # ---- Clipboard-based version ----
    # Use this if your tool automatically copies the latest transcript
    # to the Wayland clipboard when recording stops.
    if clip="$(wl-paste 2>/dev/null)" && [ -n "$clip" ]; then
        # Type the clipboard contents into the focused window.
        # Requires ydotool or wtype. Pick one.
        if command -v wtype >/dev/null 2>&1; then
            wtype "$clip"
        elif command -v ydotool >/dev/null 2>&1; then
            ydotool type -- "$clip"
        fi
    fi

    # ---- File-based version ----
    # Use this instead if your tool stores the latest transcript in a file.
    # if [ -f "$TRANSCRIPT_FILE" ]; then
    #     clip="$(cat "$TRANSCRIPT_FILE")"
    #     [ -n "$clip" ] && printf '%s' "$clip" | wl-copy
    #
    #     if command -v wtype >/dev/null 2>&1; then
    #         wtype "$clip"
    #     elif command -v ydotool >/dev/null 2>&1; then
    #         ydotool type -- "$clip"
    #     fi
    # fi

else
    # Start recording.
    nohup bash -lc "$RECORD_CMD" >/dev/null 2>&1 &
fi
