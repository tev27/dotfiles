#!/bin/bash
# install to /usr/bin/luks-automount.sh or elsewhere

LOG="/var/log/luks-automount.log"

OPENED_UUID="notreal"

PARTNOTFOUND_ret=2
ALREADYOPEN_ret=3
MOUNTDIRBUSY_ret=4
LUKSOPENFAIL_ret=5

while getopts "k:m:u:" opt; do
  case $opt in
    k) KEYFILE=$OPTARG ;;
    m) MOUNTDIR=$OPTARG ;;
    u) OPENED_UUID=$OPTARG ;;
    ?) echo "Usage luks-automount.sh [-k keyfile] [-m mountpoint] [-u opened filesystem UUID] LUKS_UUID mapperName"
  esac
done

shift $((OPTIND - 1))

if [[ $# -ne 2 ]]; then
  echo "bad options"
  exit
fi

LUKS_UUID=$1
MAPPERNAME=$2

echo "LUKS_UUID=$LUKS_UUID" | tee -a $LOG

if [[ ! -v MOUNTDIR ]]; then
  MOUNTDIR="/mnt/$MAPPERNAME"
fi

sudo_graphical() {
  local display=":0"
  local user="tev27"
  local uid=$(id -u $user)
  sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus "$@"
}

notify_log() {
  sudo_graphical notify-send -t 3000 "luks-automount.sh" "$*"
  echo "$*" | tee -a $LOG
}

mount_backups() {
  if [[ ! -e "/dev/disk/by-uuid/$LUKS_UUID" ]]; then
    notify_log "cannot find LUKS device by uuid (LUKS_UUID=$LUKS_UUID)"
    return $PARTNOTFOUND_ret || exit $PARTNOTFOUND_ret
  fi

  if [[ -e "/dev/disk/by-uuid/$OPENED_UUID" ]]; then
    notify_log "crypt block device is already available, is it already open? (OPENED_UUID=$OPENEDUUID)"
    return $ALREADYOPEN_ret || exit $ALREADYOPEN_ret
  fi

  if mountpoint -q $MOUNTDIR; then
    notify_log "mountdir is already a mount point, is it already mounted? (MOUNTDIR=$MOUNTDIR)"
    return $MOUNTDIRBUSY_ret || exit $MOUNTDIRBUSY_ret
  fi

  if [[ -e $KEYFILE ]]; then
    cryptsetup --key-file $KEYFILE open "/dev/disk/by-uuid/$LUKS_UUID" $MAPPERNAME |& tee -a $LOG
  else
    PASSWORD="$(sudo_graphical zenity --password)"
    # strip newline
    PASSWORD=${PASSWORD//[$'\n']}

    echo -n $PASSWORD | \
    cryptsetup --key-file - open "/dev/disk/by-uuid/$LUKS_UUID" $MAPPERNAME |& tee -a $LOG
  fi

  if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    return $LUKSOPENFAIL_ret || exit $LUKSOPENFAIL_ret
  fi

  systemd-mount "/dev/mapper/$MAPPERNAME" $MOUNTDIR |& tee -a $LOG
  if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
    notify_log "mounted $MAPPERNAME"
  fi

  echo "done" | tee -a $LOG
}

# allow sourcing
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  mount_backups
fi
