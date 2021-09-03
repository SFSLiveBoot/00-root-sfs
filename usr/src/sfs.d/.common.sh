#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}

: ${dist:=$(awk '/^deb /{print $3}' $DESTDIR/etc/apt/sources.list | head -1)}
: ${repo:=$(awk '/^deb /{print $2}' $DESTDIR/etc/apt/sources.list | head -1)}

: "${pkgs:=$(sed -Ee 's/(^|[[:space:]])#.*//' "$(dirname "$0")/.pkgs" | grep -v '^$' | tr '\n' ' ')}"

# packages which have to be installed after others
test -n "${stage2_pkgs+set}" || stage2_pkgs="ibus-clutter ibus-gtk ibus-input-pad ibus-wayland ibus-gtk3"

# potentially conflicting or problematic services
: "${disable_defsvc:=strongswan nfs-server hostapd}"

: "${inst_pkgs:=cdebootstrap lsof}"
