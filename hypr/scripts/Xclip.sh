
#!/usr/bin/env bash
#
# poll the X clipboard and feed into cliphist
#
# -selection clipboard = “main” copy/paste buffer via XWayland
# -o                   = print the current clipboard contents to stdout
#
while true; do
    xclip \
      -selection clipboard \        # choose the X clipboard
      -o \                          # output its contents
    | cliphist store                # send into your history manager
    sleep 0.5                       # poll interval (seconds)
done
