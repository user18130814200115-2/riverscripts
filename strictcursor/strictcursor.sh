#!/bin/sh

clicker() {
    # Unmap mod to drag for the moment
    # Otherwise when for instance spawning a window with Mod+Return, the window will be set to floating
    riverctl unmap-pointer normal Mod4 BTN_LEFT
    # Click to focus the window
    wlrctl pointer click
    # Remap Mod+drag from above
    riverctl map-pointer normal Mod4 BTN_LEFT move-view
}

while sleep 0.1; do
    # Check if the focus is on a different window or if there are more/less windows than last time,
    # if so, click
    [ "$prev" = "$(lswt -t | cut -f5)" ] || clicker
    # Save the current list of windows for use in the next run
    prev=$(lswt -t | cut -f5)
done
