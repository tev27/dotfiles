# My dotfiles

# Mangowm

## Keybinds
### Navigation
### Screenshots
- Super,s grab whole screen, store in Pictures/Screenshots, copy to clipboard
- Super+Ctrl,s grab whole screen, copy to clipboard
- Super+Shift,s grab region (given by slurp), store in Pictures/Screenshots, copy to clipboard

# udev rules
## luks drive automount
Install luks-automount.sh in /usr/bin

Add a new udev rule to /etc/udev/rules.d/ (I use `81-mapname-usb-mount.rules`), e.g.
```
ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="crypto_LUKS", ENV{ID_VENDOR_ID}=="****", ENV{ID_MODEL_ID}=="****", ENV{ID_USB_SERIAL_SHORT}=="*************", ENV{ID_FS_UUID}=="********-****-****-****-************", RUN+="/usr/bin/luks-automount.sh -u ********-****-****-****-************ %E{ID_FS_UUID} mapperName"
```

TODO: list options

you can find these values with
```
udevadm info /dev/{device}
```
or
```
udevadm monitor --property --udev
```

I still need to add a status bar and scripts to easily unmount dm-crypt devices
