#!/bin/bash

# start graphical polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# Keep clipboard content after app closes
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# Watch clipboard and store history
wl-paste --type text --watch cliphist store &
